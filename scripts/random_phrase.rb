#!/usr/bin/env ruby

adjectives = %w(
  good
  bad
  terrible
  wonderful
  sweet
  miserable
  awful
  acceptable
  big
  tiny
  huge
  loud
  quiet
  peaceful
  tolerable
  intolerable
  magic
  mysterious
  mystical
  bewitched
  musical
  screaming
  sobbing
)

nouns = %w(
  person
  place
  thing
  building
  baby
  cat
  horse
  mouse
  dog
  puppy
  chicken
  bird
  computer
  river
  mountain
  wasteland
  disaster
  trough
  rock
  puppet
  wizard
  witch
  goblin
  orc
  whale
  dolphin
  bean
  carrot
  potato
  lizard
)

puts "#{adjectives.sample}-#{adjectives.sample}-#{nouns.sample}"
