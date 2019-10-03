require 'open3'
require 'json'

module Exosuit
  class Instance
    IMAGE_NAME = '/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2'
    INSTANCE_TYPE = 't2.micro'

    def self.to_s(instance)
      tags = instance.tags.map { |t| "#{t.key}:#{t.value}" }.join(', ')
      tags = nil if tags == ''

      [
        instance.id,
        instance.state.name,
        tags,
        instance.public_dns_name
      ].compact.join("\n")
    end

    def self.launch(key_pair)
      Exosuit::ec2.create_instances(
        min_count: 1,
        max_count: 1,
        image_id: latest_ami_id,
        instance_type: INSTANCE_TYPE,
        key_name: key_pair.name
      ).first
    end

    def self.ssh(public_dns_name)
      command = %(
        ssh -i #{Exosuit.config.values['key_pair']['path']} \
          -o StrictHostKeychecking=no ubuntu@#{public_dns_name}
      )

      system(command)
    end

    def self.all
      Exosuit.ec2.instances
    end

    def self.running
      all.select { |i| i.state.name == 'running' }
    end

    def self.latest_ami_id
      Aws::SSM::Client.new(profile: profile_name)
                      .get_parameters(names: [IMAGE_NAME])
                      .parameters[0]
                      .value
    end
  end
end
