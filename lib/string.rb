# frozen_string_literal: true

# to colorize strings
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

  def white
    "\e[97m#{self}"
  end

  def default
    "\e[39m#{self}"
  end

  def black
    "\e[30m#{self}"
  end

  def red
    "\e[31m#{self}"
  end

  def green
    "\e[92m#{self}"
  end

  def bg_red
    "\e[101m#{self}"
  end

  def bg_gray
    "\e[100m#{self}"
  end

  def bg_default
    "\e[49m#{self}"
  end
end
