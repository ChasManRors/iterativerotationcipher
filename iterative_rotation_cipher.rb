# frozen_string_literal: true

# Alternatively use #!/usr/bin/env ruby & cmdline.rb
require 'fileutils'
require 'pry'

# Auto generated Code from Dash rspec.init v 0.0.12 written by Charles M Magid - generated at 11:52 AM on Jul 8, 2021
class IterativeRotationCipher
  def initialize; end


  def encode(number, string)
    result = string
    number.times do |_num|
      result = sub_encode(number, result)
      puts result
    end
    puts "#{number} #{result}"
    "#{number} #{result}"
  end

  def sub_encode(number, string)
    # Step 0 — index all spaces:
    indices = []
    # string.each_char.with_index { |c, i| indices << i if /\s/ =~ c }
    # string.each_char.with_index { |c, i| indices << i if c == ' ' }
    string.each_char.with_index { |c, i| indices << [i, :space] if c == ' '; indices << [i, :newline] if c == "\n" }
    binding.pry
    
    # Step 1 — remove all spaces:
    string2 = string.gsub(/ /, '')
    
    # Step 2 — shift the order of string characters to the right by 10:
    string3 = string2.split('').rotate(-number).join
    
    # Step 3 — place the spaces back in their original positions:
    # indices.each_with_object(string3){ |index, string4| string4.insert(index, ' ') }
    string4 = indices.each_with_object(string3) { |index, tmp| 
      
      # tmp.insert(index.first, "\n") if (index.last == :newline)
    tmp.insert(index.first, " ") if (index.last == :space)
    }
    # Step 4 — shift the order of characters for each space-separated substring to the right by 10:
    string4.split(' ').map { |substr| substr.split('').rotate(-number).join }.join(' ')
  end

  def decode(string)
    # ... and here
  end
end
