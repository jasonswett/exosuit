require 'open3'
require 'json'

module Exosuit
  class Instance
    IMAGE_ID = 'ami-05c1fa8df71875112'
    INSTANCE_TYPE = 't2.micro'

    def self.launch(keypair)
      command = %(
        aws ec2 run-instances --profile=#{Exosuit.config.values['aws_profile_name']} \
          --count 1 \
          --image-id #{IMAGE_ID} \
          --instance-type #{INSTANCE_TYPE} \
          --key-name #{keypair.name}
      )

      response = Open3.capture3(command)[0]
      JSON.parse(response)
    end
  end
end
