require 'open3'
require 'json'
require 'pry'

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

    def self.launch(keypair)
      command = %(
        aws ec2 run-instances --profile=#{Exosuit.config.values['aws_profile_name']} \
          --count 1 \
          --image-id #{IMAGE_ID} \
          --instance-type #{INSTANCE_TYPE} \
          --key-name #{keypair.name}
      )

      raw_response = Open3.capture3(command)[0]
      JSON.parse(raw_response)
    end

    def self.all
      command = %(
        aws ec2 describe-instances --profile=#{Exosuit.config.values['aws_profile_name']}
          --filters Name=instance-state-name,Values=running
      )

      raw_response = Open3.capture3(command)[0]
      response = JSON.parse(raw_response)

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
