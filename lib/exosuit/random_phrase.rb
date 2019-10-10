# frozen_string_literal: true

module Exosuit
  class RandomPhrase
    ADJECTIVES = %w[
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
      squashed
    ].freeze

    NOUNS = %w[
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
      elephant
      sloth
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
    ].freeze

    def self.generate
      "#{ADJECTIVES.sample}-#{ADJECTIVES.sample}-#{NOUNS.sample}"
    end
  end
end
