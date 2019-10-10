# frozen_string_literal: true

require 'yaml'

module Exosuit
  class Configuration
    CONFIG_DIR = './.exosuit'
    CONFIG_FILENAME = 'config.yml'
    FILENAME = "#{CONFIG_DIR}/#{CONFIG_FILENAME}"

    def update_key_pair(name:, path:)
      ensure_file_exists

      config = values
      config['key_pair'] ||= {}
      config['key_pair']['name'] = name
      config['key_pair']['path'] = path
      save(config)
    end

    def values
      ensure_file_exists
      YAML.load_file(FILENAME)
    end

    def set(options)
      ensure_file_exists
      save(values.merge(options))
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
