# frozen_string_literal: true

# Alternatively use #!/usr/bin/env ruby & cmdline.rb
require 'fileutils'
require 'pry'

# Auto generated Code from Dash rspec.init v 0.0.12 written by Charles M Magid - generated at 11:52 AM on Jul 8, 2021
class IterativeRotationCipher
  def initialize; end

  def encode(number, string)
    # binding.pry # => "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"
    result = string
    number.times do |_num| # => 36
      result = sub_encode(number, result)
    end
    "#{number} #{result}"
  end

  def sub_encode(number, string)
    # binding.pry
    # ** Step 0 — index all spaces:

    # INPUT -  number: 36, string: "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"
    indices = []
    string.each_char.with_index { |c, i| indices << i if c == ' ' }
    # OUTPUT -  indices: [2, 4, 8, 14, 17, 21, 29, 33, 35, 39, 43, 50, 60, 67, 73, 79, 89, 93, 95, 100, 105, 108]

    # ** Step 1 remove all spaces:

    # INPUT - string: "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"
    string2 = string.gsub(/ /, '')
    # OUTPUT - string2: "AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tthereagaintoday,\nOhhowIwishhe'dgoaway!"

    # ** Step 2 shift the order of string characters to the right by N:

    # INPUT - string2: "AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tthereagaintoday,\nOhhowIwishhe'dgoaway!", number: 36
    string3 = string2.split('').rotate(-number).join
    # OUTPUT - string3: "ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth"

    # ** Step 3 place the spaces back in their original positions:

    # INPUT - string3: "ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth"
    #       - indices: [2, 4, 8, 14, 17, 21, 29, 33, 35, 39, 43, 50, 60, 67, 73, 79, 89, 93, 95, 100, 105, 108]
    string4 = string3.dup
    indices.each_with_object(string4) { |index, a| a.insert(index, ' ') }
    # OUTPUT - string4: "er e aga intod ay ,\nO hhowIwi shh e 'dg oaw ay!AsI wasgoingu pthest air\nI metam anwhowasn 'tt h ere! \nHew as n'tth"

    # ** Step 4 shift the order of characters for each space-separated substring to the right by N:
    # binding.pry
    # INPUT string4: "er e aga intod ay ,\nO hhowIwi shh e 'dg oaw ay!AsI wasgoingu pthest air\nI metam anwhowasn 'tt h ere! \nHew as n'tth"
    string5 = string4.split(/ |\t|\r|\f/).map { |substr| substr.split('').rotate(-number).join }.join(' ')
    # OUTPUT - result "er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    return string5
  end

  def peal(string)
    # **** Peal off the number from the string
    index = string.index ' '
    number = string.slice(0..index - 1).to_i
    # string1 = string.slice(index..-1).lstrip
    [number, string.slice(index..-1).lstrip]
  end

  def decode(string)
    number, string1 = peal(string)
    result = string1
    number.times do # |_num| # => 36
      # binding.pry
      result = sub_decode(number, result)
    end
    "#{result}"
  end


  def sub_decode(number, string)
    # binding.pry
    # capture indices of space
    indices = []
 
    string.each_char.with_index { |c, i| indices << i if c == ' ' }
    # binding.pry
    # binding.pry
    # **** Step 4i shift the order of characters for each space-separated substring to the left by N:
    # INPUT - result "er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    string2 = string.split(/ |\t|\r|\f/).map { |substr| substr.split('').rotate(number).join }.join(' ')
    # OUTPUT string4: "er e aga intod ay ,\nO hhowIwi shh e 'dg oaw ay!AsI wasgoingu pthest air\nI metam anwhowasn 'tt h ere! \nHew as n'tth"

    # **** Step 3i remove spaces
    # INPUT - string4: "er e aga intod ay ,\nO hhowIwi shh e 'dg oaw ay!AsI wasgoingu pthest air\nI metam anwhowasn 'tt h ere! \nHew as n'tth"
    string3 = string2.gsub(/ /, '')
    # OUTPUT - string3: "ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth"

    # ** Step 2i shift the order of string characters to the left by N:
    # INPUT -  "ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth"
    string4 = string3.split('').rotate(number).join
    # OUTPUT - "AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tthereagaintoday,\nOhhowIwishhe'dgoaway!", number: 36

    # **** Step 1i add back all spaces:
    # INPUT - string2: "AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tthereagaintoday,\nOhhowIwishhe'dgoaway!"
    #       - indices: [2, 4, 8, 14, 17, 21, 29, 33, 35, 39, 43, 50, 60, 67, 73, 79, 89, 93, 95, 100, 105, 108]
    string5 = string4.dup
    string6 = indices.each_with_object(string5) { |index, a| a.insert(index, ' ') }
    # OUTPUT => "I' et a nan twher eo s\ns her!tHe aea ' gwa din \nthawn htoo,I'is yohOya wshwe AgIaa dugowh!as rit n git\n msmp hw tea"
    return string6
  end
end
