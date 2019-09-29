require 'json'
require 'open3'
require 'tty-prompt'
require 'pry'
require_relative 'exosuit/configuration'
require_relative 'exosuit/key_pair'
require_relative 'exosuit/instance'
require_relative 'exosuit/help'

module Exosuit
  def self.config
    Configuration.new
  end

  def self.launch_instance
    response = Instance.launch(self.key_pair)
    instance_id = response['Instances'][0]['InstanceId']
    print "Launching instance #{instance_id}..."

    while true
      sleep(1)
      print '.'
      instance = Instance.find(instance_id)

      if instance && instance.running?
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

  def self.terminate
    running_instances = Instance.running

    unless running_instances.any?
      puts 'No running instances to terminate'
      return
    end

    instance_ids_to_terminate = prompt.multi_select(
      'Which instance(s)?',
      running_instances.map(&:instance_id)
    )

    Instance.terminate(instance_ids_to_terminate)
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
