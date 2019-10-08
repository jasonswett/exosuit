require 'aws-sdk-ec2'
require 'json'
require 'open3'
require 'tty-prompt'
require_relative 'exosuit/configuration'
require_relative 'exosuit/key_pair'
require_relative 'exosuit/instance'
require_relative 'exosuit/help'

module Exosuit
  VERSION = '0.0.3'

  def self.config
    Configuration.new
  end

  def self.profile_name
    Exosuit.config.values['aws_profile_name']
  end

  def self.ec2
    @ec2 ||= Aws::EC2::Resource.new(profile: profile_name)
  end

  def self.aws_client
    @aws_client ||= Aws::EC2::Client.new(profile: profile_name)
  end

  def self.launch_instance
    instance = Instance.launch(self.key_pair)
    print "Launching instance #{instance.id}..."

    while true
      sleep(1)
      print '.'

      if instance.reload.state.name == 'running'
        puts
        break
      end
    end

    puts 'Instance is now running'
    puts "Public DNS: #{instance.public_dns_name}"
  end

  def self.key_pair
    if config.values['key_pair'] && config.values['key_pair']['path']
      KeyPair.new(
        config.values['key_pair']['name'],
        config.values['key_pair']['path']
      )
    else
      generate_key_pair
    end
  end

  def self.generate_key_pair
    KeyPair.new.save.tap do |key_pair|
      config.update_key_pair(name: key_pair.name, path: key_pair.filename)
      puts "Successfully created new key pair at #{key_pair.filename}"
    end
  end

  def self.public_dns_names
    Instance.running.map(&:public_dns_name)
  end

  def self.ssh
    public_dns_name = prompt.select('Which instance?', public_dns_names)
    Instance.ssh(public_dns_name)
  end

  def self.initialize
    public_dns_name = prompt.select('Which instance?', public_dns_names)
    Instance.initialize(public_dns_name)
  end

  def self.terminate
    running_instances = Instance.running

    unless running_instances.any?
      puts 'No running instances to terminate'
      return
    end

    instance_ids = prompt.multi_select(
      'Which instance(s)?',
      running_instances.map(&:id)
    )

    Exosuit.aws_client.terminate_instances(instance_ids: instance_ids)
  end

  def self.open
    public_dns_name = prompt.select('Which instance?', public_dns_names)
    system("open http://#{public_dns_name}")
  end

  private

  def self.prompt
    @prompt ||= TTY::Prompt.new
  end
end
