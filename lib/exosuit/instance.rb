require 'open3'
require 'json'
require_relative 'aws_command'

module Exosuit
  class Instance
    IMAGE_ID = 'ami-05c1fa8df71875112'
    INSTANCE_TYPE = 't2.micro'

    def initialize(info)
      @info = info
    end

    def instance_id
      @info['InstanceId']
    end

    def instance_type
      @info['InstanceType']
    end

    def state
      @info['State']['Name']
    end

    def public_dns_name
      @info['PublicDnsName']
    end

    def running?
      state == 'running'
    end

    def self.find(instance_id)
      all.find { |i| i.instance_id == instance_id }
    end

    def to_s
      [instance_id, state, public_dns_name].compact.join("\n")
    end

    def self.launch(key_pair)
      command = AWSCommand.new(
        :run_instances,
        count: 1,
        image_id: IMAGE_ID,
        instance_type: INSTANCE_TYPE,
        key_name: key_pair.name
      )

      JSON.parse(command.run)
    end

    def self.ssh(public_dns_name)
      command = %(
        ssh -i #{Exosuit.config.values['key_pair']['path']} \
          -o StrictHostKeychecking=no ubuntu@#{public_dns_name}
      )

      system(command)
    end

    def self.terminate(instance_ids)
      command = AWSCommand.new(
        :terminate_instances,
        instance_ids: instance_ids.join(' ')
      )

      system(command.to_s)
    end

    def self.all
      command = AWSCommand.new(:describe_instances)
      response = JSON.parse(command.run)

      response['Reservations'].map do |reservation|
        info = reservation['Instances'][0]
        Instance.new(info)
      end
    end

    def self.running
      all.select(&:running?)
    end
  end
end
