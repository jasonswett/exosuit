require 'json'
require 'open3'
require_relative 'exosuit/configuration'
require_relative 'exosuit/random_phrase'

module Exosuit
  def self.config
    Configuration.new
  end

  def self.launch_instance
    generate_keypair

    command = %(
      aws ec2 run-instances --profile=#{config.values['aws_profile_name']} \
        --image-id ami-05c1fa8df71875112 \
        --count 1 \
        --instance-type t2.micro \
        --key-name #{config.values['keypair']['name']}
    )

    system(command)
  end

  def self.generate_keypair
    keypair_name = RandomPhrase.generate
    keypair_filename = "~/.ssh/#{keypair_name}.pem"

    command = %(
      aws ec2 create-key-pair --profile=#{config.values['aws_profile_name']} \
        --key-name #{keypair_name} \
        --query 'KeyMaterial' \
        --output text > #{keypair_filename}
    )

    system(command)
    system("chmod 400 #{keypair_filename}")

    config.update_keypair(name: keypair_name, path: keypair_filename)
    puts "Successfully created new keypair at #{keypair_filename}"
  end

  def self.dns_names
    command = "aws ec2 describe-instances --filters Name=instance-state-name,Values=running --profile=#{Exosuit.config.values['aws_profile_name']}"
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
