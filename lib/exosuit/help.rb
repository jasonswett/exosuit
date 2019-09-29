module Exosuit
  module Help
    def self.help_text
    %(Usage:
  exo [command]

These are the commands you can use:
  launch                 Launch a new EC2 instance
  terminate              Terminate an EC2 instance
  instances              Show a summary of all EC2 instances
  instances:running      Show only running instances
  dns                    List public DNS names for all EC2 instances
  ssh                    SSH into an EC2 instance)
    end
  end
end
