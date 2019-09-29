require 'open3'

module Exosuit
  class AWSCommand
    def initialize(command, options = {})
      @command = dasherize(command)

      config = options.delete(:config) || Exosuit.config.values
      @options = options
      @options[:profile] = config['aws_profile_name'] if config
    end

    def serialized_options
      @options.map do |key, value|
        "--#{dasherize(key)} #{value}"
      end.join(' ')
    end

    def to_s
      %(
        aws ec2 #{@command} #{serialized_options}
      ).strip
    end

    def run
      Open3.capture3(to_s)[0]
    end

    private

    def dasherize(value)
      value.to_s.gsub(/_/, '-')
    end
  end
end
