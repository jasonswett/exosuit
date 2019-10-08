module Exosuit
  module Help
    def self.help_text
    %(Usage:
  exo [command]

These are the commands you can use:
  launch                 Launch a new EC2 instance
  terminate              Terminate an EC2 instance
  instances              Show a summary of all running EC2 instances
  instances:all          Show a summary of EC2 instances (all states)
  dns                    List public DNS names for all EC2 instances
  ssh                    SSH into an EC2 instance
  initialize             Install Ruby and nginx on an instance)
    end
  end
end
