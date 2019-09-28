require_relative './random_phrase'

module Exosuit
  class KeyPair
    attr_accessor :name, :filename

    def initialize(name = nil, filename = nil)
      @name = name || RandomPhrase.generate
      @filename = filename || "~/.ssh/#{@name}.pem"
    end

    def save
      command = %(
        aws ec2 create-key-pair --profile=#{Exosuit.config.values['aws_profile_name']} \
          --key-name #{@name} \
          --query 'KeyMaterial' \
          --output text > #{filename}
      )

      system(command)
      system("chmod 400 #{filename}")
      self
    end
  end
end
