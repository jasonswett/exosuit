require 'json'
require 'open3'

module Exosuit
  require 'yaml'

  def self.config
    config_dir = './.exosuit'
    filename = "#{config_dir}/config.yml"
    YAML::load_file(filename)
  end

  def self.dns_names
    command = "aws ec2 describe-instances --filters Name=instance-state-name,Values=running --profile=#{Exosuit.config['aws_profile_name']}"
    response, _, _ = Open3.capture3(command)

    JSON.parse(response)['Reservations'].map do |data|
      data['Instances'][0]['PublicDnsName']
    end
  end

  def self.help_text
    %(Usage:
  exo [command]

These are the commands you can use:
  launch                 Launch a new EC2 instance
  describe-instances     Alias for aws ec2 describe-instances
  dns                    List public DNS names for all EC2 instances
  ssh                    SSH into an EC2 instance)
  end
end
