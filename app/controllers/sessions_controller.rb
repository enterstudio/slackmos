# Session controller for authenticating users with GitHub/Heroku/Hipchat
class SessionsController < ApplicationController
  def create_slack
    user = User.find_or_initialize_by(slack_user_id: omniauth_info_user_id)
    user.slack_user_name   = omniauth_info["info"]["user"]
    user.slack_team_id     = omniauth_info["info"]["team_id"]

    user.save
    session[:user_id] = user.id
    redirect_to after_successful_slack_user_setup_path
  end

  def create_google
    Rails.logger.info "Logged in as #{omniauth_info['info']['email']}."
    redirect_to after_successful_google_user_setup_path
  end

  def complete
    @after_success_url = "https://slack.com/messages/general"
    if params[:origin]
      decoded = Slackmos.decode_origin(params[:origin])

      @after_success_url = decoded[:uri] if decoded[:uri] =~ /^slack:/

      command = Command.find(decoded[:token])
      SignupCompleteJob.perform_later(command_id: command.id) if command
    end
  rescue StandardError, ActiveRecord::RecordNotFound
    nil
  end

  def destroy
    session.clear
    redirect_to root_url, notice: "Signed out!"
  end

  private

  def after_successful_google_user_setup_path
    "/auth/complete?origin=#{omniauth_origin}"
  end

  def after_successful_slack_user_setup_path
    "/auth/google_oauth2?origin=#{omniauth_origin}"
  end

  def omniauth_origin
    request.env["omniauth.origin"]
  end

  def omniauth_info_user_id
    omniauth_info["info"]["user_id"]
  end

  def omniauth_refresh_token
    omniauth_info["credentials"]["refresh_token"]
  end

  def omniauth_expiration
    Time.at(omniauth_info["credentials"]["expires_at"]).utc
  end

  def omniauth_info
    request.env["omniauth.auth"]
  end
end
