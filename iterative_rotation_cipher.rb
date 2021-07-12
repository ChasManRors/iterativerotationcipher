# frozen_string_literal: true

# Alternatively use #!/usr/bin/env ruby & cmdline.rb
require 'fileutils'
require 'pry'

# Auto generated Code from Dash rspec.init v 0.0.12 written by Charles M Magid - generated at 11:52 AM on Jul 8, 2021
class IterativeRotationCipher
  def initialize; end

  def encode(number, string)
    number.times { string = encode_steps(number, string) }
    "#{number} #{string}"
  end

  def decode(string)
    number, str = separate(string)
    number.times { str = decode_steps(number, str) }
    str
  end

  private

  def index_spaces(string)
    string.chars.each_with_object([]).with_index { |(char, result), i| result << i if char == ' ' }
  end

  def rrotate(string, number)
    string.chars.rotate(-number).join
  end

  def lrotate(string, number)
    rrotate(string, -number)
  end

  # ** Peel off the number from front of the string returning both
  def separate(string)
    index = string.index ' '
    number = string.slice(0..index - 1).to_i
    [number, string.slice(index..-1).lstrip]
  end

  def encode_steps(number, str)
    string = str.dup

    # ** Step 0 - index all spaces:
    indices = index_spaces(string)

    # ** Step 1 remove all spaces:
    string.gsub!(/ /, '')

    # ** Step 2 shift the order of string characters to the right by N:
    string = rrotate(string, number)

    # ** Step 3 place the spaces back in their original positions:
    indices.each_with_object(string) { |index, a| a.insert(index, ' ') }

    # ** Step 4 shift the order of characters for each space-separated substring to the right by N:
    string.split(/ |\t|\r|\f/).map { |s| rrotate(s, number) }.join ' '
  end

  def decode_steps(number, string)
    # Capture indices of spaces
    indices = index_spaces(string)

    # **** Step 4i shift the order of characters for each space-separated substring to the left by N:
    string = string.split(/ |\t|\r|\f/).map { |s| lrotate(s, number) }.join ' '

    # **** Step 3i remove spaces
    string = string.gsub(/ /, '')

    # ** Step 2i shift the order of string characters to the left by N:
    string = lrotate(string, number)

    # **** Step 1i add back all spaces:
    indices.each_with_object(string) { |index, a| a.insert(index, ' ') }
  end
end
