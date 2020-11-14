# frozen_string_literal: true

# Can colorize strings
class String
  def primary
    "\e[37m#{self}\e[0m"
  end

  def secondary
    "\e[30m#{self}\e[0m"
  end

  def bg_primary
    "\e[48;5;130m#{self}\e[0m"
  end

  def bg_secondary
    "\e[48;5;52m#{self}\e[0m"
  end
end