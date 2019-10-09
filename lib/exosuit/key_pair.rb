# frozen_string_literal: true

require_relative './random_phrase'

module Exosuit
  class KeyPair
    attr_accessor :name, :filename

    def initialize(name = nil, filename = nil)
      @name = name || RandomPhrase.generate
      @filename = filename || File.expand_path("~/.ssh/#{@name}.pem")
    end

    def save
      key_pair = Exosuit.ec2.create_key_pair(key_name: @name)

      File.open(filename, 'w') do |file|
        file.write(key_pair.key_material)
      end

      system("chmod 400 #{filename}")
      self
    end
  end
end
