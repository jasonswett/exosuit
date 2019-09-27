#!/usr/bin/env ruby

require_relative '../lib/exosuit'
Exosuit.config.update_keypair(name: ARGV[0], path: ARGV[1])
