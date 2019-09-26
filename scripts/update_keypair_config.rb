#!/usr/bin/env ruby

require 'yaml'

config_dir = './.exosuit'
filename = "#{config_dir}/config.yml"

Dir.mkdir(config_dir) unless File.exist?(filename)
File.write(filename, {}.to_yaml) unless File.exist?(filename)

config = YAML::load_file(filename)

config['keypair'] ||= {}
config['keypair']['name'] = ARGV[0]
config['keypair']['path'] = ARGV[1]

File.write(filename, config.to_yaml)
