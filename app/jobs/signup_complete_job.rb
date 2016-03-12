# Job to handle notifying the user that they're done signing up
class SignupCompleteJob < ApplicationJob
  queue_as :default

  def perform(*args)
    command_id = args.first.fetch(:command_id)

    command = Command.find(command_id)
    Team.find_or_create_by(team_id: command.team_id) do |team|
      team.team_domain = command.team_domain
    end

    command.notify_user_of_success!
  end
end
