require 'open3'
require 'json'

module Exosuit
  class Instance
    IMAGE_ID = 'ami-05c1fa8df71875112'
    INSTANCE_TYPE = 't2.micro'

    def self.to_s(instance)
      [
        instance.id,
        instance.state.name,
        instance.public_dns_name
      ].compact.join("\n")
    end

    def self.launch(key_pair)
      Exosuit::ec2.create_instances(
        min_count: 1,
        max_count: 1,
        image_id: IMAGE_ID,
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
  end
end
