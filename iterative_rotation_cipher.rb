# frozen_string_literal: true

# Alternatively use #!/usr/bin/env ruby & cmdline.rb
require 'fileutils'
require 'pry'

# Auto generated Code from Dash rspec.init v 0.0.12 written by Charles M Magid - generated at 11:52 AM on Jul 8, 2021
class IterativeRotationCipher
  def initialize; end

  def encode(number, string)
    number.times do |_num| # => 36
      string = sub_encode(number, string)
    end
    "#{number} #{string}"
  end

  def sub_encode(number, string)
    # ** Step 0 - index all spaces:

    indices = []
    string.each_char.with_index { |c, i| indices << i if c == ' ' }

    # ** Step 1 remove all spaces:
    string = string.gsub(/ /, '')

    # ** Step 2 shift the order of string characters to the right by N:
    string = string.split('').rotate(-number).join

    # ** Step 3 place the spaces back in their original positions:
    binding.pry
    string4 = string.dup
    indices.each_with_object(string4) { |index, a| a.insert(index, ' ') }

    # ** Step 4 shift the order of characters for each space-separated substring to the right by N:
    string4.split(/ |\t|\r|\f/).map { |substr| substr.split('').rotate(-number).join }.join(' ')
  end

  def peal(string)
    # ** Peal off the number from the string
    index = string.index ' '
    number = string.slice(0..index - 1).to_i
    [number, string.slice(index..-1).lstrip]
  end

  def decode(string)
    number, string1 = peal(string)
    result = string1
    number.times do # |_num| # => 36
      result = sub_decode(number, result)
    end
    result.to_s
  end

  def sub_decode(number, string)
    # capture indices of spaces
    indices = []
    string.each_char.with_index { |c, i| indices << i if c == ' ' }
    # **** Step 4i shift the order of characters for each space-separated substring to the left by N:
    string2 = string.split(/ |\t|\r|\f/).map { |substr| substr.split('').rotate(number).join }.join(' ')

    # **** Step 3i remove spaces
    string3 = string2.gsub(/ /, '')

    # ** Step 2i shift the order of string characters to the left by N:
    string4 = string3.split('').rotate(number).join

    # **** Step 1i add back all spaces:
    string5 = string4.dup
    indices.each_with_object(string5) { |index, a| a.insert(index, ' ') }
  end
end
