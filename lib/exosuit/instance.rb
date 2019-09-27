module Exosuit
  class Instance
    def self.launch(keypair)
      command = %(
        aws ec2 run-instances --profile=#{Exosuit.config.values['aws_profile_name']} \
          --image-id ami-05c1fa8df71875112 \
          --count 1 \
          --instance-type t2.micro \
          --key-name #{keypair.name}
      )

      system(command)
    end
  end
end
