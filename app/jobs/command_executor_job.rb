# Job to handle heroku command execution
class CommandExecutorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    command_id = args.first.fetch(:command_id)
    command = Command.find(command_id)

    Team.find_or_create_by(team_id: command.team_id) do |team|
      team.team_domain = command.team_domain
    end

    command.run
    command.processed_at = Time.now.utc
    command.save
  end
end
