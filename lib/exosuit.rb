require 'json'

module Exosuit
  require 'yaml'

  def self.config
    config_dir = './.exosuit'
    filename = "#{config_dir}/config.yml"
    YAML::load_file(filename)
  end

  def self.dns_names
    command = "aws ec2 describe-instances --filters Name=instance-state-name,Values=running --profile=#{Exosuit.config['aws_profile_name']}"
    response, _, _ = Open3.capture3(command)

    JSON.parse(response)['Reservations'].map do |data|
      data['Instances'][0]['PublicDnsName']
    end
  end
end
