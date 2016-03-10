# A user from the Slack API
class User < ApplicationRecord
  has_many :commands, dependent: :destroy

  def create_command_for(params)
    command = commands.create(
      channel_id: params[:channel_id],
      channel_name: params[:channel_name],
      command: params[:command],
      command_text: params[:text],
      response_url: params[:response_url],
      team_id: params[:team_id],
      team_domain: params[:team_domain]
    )
    CommandExecutorJob.perform_later(command_id: command.id)
    command
  end
end
