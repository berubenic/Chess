# frozen_string_literal: true

require 'ruby_figlet'
using RubyFiglet

module Chess
  # Prints Board and messages
  module Display
    def title_message
      puts '--------'.art
      puts '             Chess'.art
      puts '--------'.art
    end
  end
end
