# frozen_string_literal: true

require 'aws-sdk-ec2'
require 'json'
require 'open3'
require 'net/http'
require 'openssl'
require 'tty-prompt'
require_relative 'exosuit/configuration'
require_relative 'exosuit/key_pair'
require_relative 'exosuit/instance'
require_relative 'exosuit/help'

module Exosuit
  VERSION = '0.0.5'

  def self.config
    Configuration.new
  end

  def self.profile_name
    config.values['aws_profile_name']
  end

  def self.ec2
    @ec2 ||= Aws::EC2::Resource.new(profile: profile_name)
  end

  def self.aws_client
    @aws_client ||= Aws::EC2::Client.new(profile: profile_name)
  end

  def self.launch_instance
    instance = Instance.launch(key_pair)
    config.set('primary_instance_id' => instance.id)
    print "Launching instance #{instance.id}..."

    loop do
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
    system("open http://#{Instance.primary.public_dns_name}")
  end

  def self.create
    uri = URI('https://app.exosuit.io/api/v1/apps')

    email = prompt.ask('Exosuit email:')
    password = prompt.mask('Exosuit password:')

    Net::HTTP.start(
      uri.hostname,
      uri.port,
      use_ssl: true,
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      request = Net::HTTP::Post.new(uri)
      request.basic_auth email, password
      request.set_form_data('app[name]' => config.values['app_name'])
      http.request(request)
    end
  end

  private

  def self.prompt
    @prompt ||= TTY::Prompt.new
  end
end
