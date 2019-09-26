#!/usr/bin/env ruby

adjectives = %w(
  good
  bad
  terrible
  wonderful
  sweet
  miserable
  awful
  big
  tiny
  huge
  loud
  quiet
  peaceful
  intolerable
  magic
  mysterious
  mystical
  bewitched
  musical
  screaming
  sobbing
  weird
  strange
  normal
  fantastic
  enchanting
  evil
  malevolent
  stupid
  cool
  awesome
  radical
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
  elf
  soup
  pizza
  banana
  volcano
)

puts "#{adjectives.sample}-#{adjectives.sample}-#{nouns.sample}"
