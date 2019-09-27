require 'yaml'

module Exosuit
  class Configuration
    CONFIG_DIR = './.exosuit'
    CONFIG_FILENAME = 'config.yml'
    FILENAME = "#{CONFIG_DIR}/#{CONFIG_FILENAME}"

    def update_keypair(name:, path:)
      ensure_file_exists

      config = values
      config['keypair'] ||= {}
      config['keypair']['name'] = name
      config['keypair']['path'] = path
      save(config)
    end

    def values
      YAML::load_file(FILENAME)
    end

    private

    def save(config)
      File.write(FILENAME, config.to_yaml)
    end

    def ensure_file_exists
      Dir.mkdir(CONFIG_DIR) unless File.exist?(FILENAME)
      File.write(FILENAME, {}.to_yaml) unless File.exist?(FILENAME)
    end
  end
end
