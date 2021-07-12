# frozen_string_literal: true

class IterativeRotationCipherDeDe
  def encode(n, s, counter = 1)
    binding.pry
    space_indexes = get_whitespace_indexes(s)
    s = insert_whitespaces(rotate_str_right(remove_whitespaces(s), n), space_indexes)
    s = s.split(/ /).map { |subs| rotate_str_right(subs, n) }.join(' ')
    counter >= n ? "#{n} #{s}" : encode(n, s, counter + 1)
  end

  def decode(s, n = nil, counter = 1)
    unless n
      n, s = s.split(' ', 2)
      n = n.to_i
    end
    space_indexes = get_whitespace_indexes(s)
    s = s.split(/ /).map { |subs| rotate_str_left(subs, n) }.join(' ')
    s = insert_whitespaces(rotate_str_left(remove_whitespaces(s), n), space_indexes)
    counter >= n ? s : decode(s, n, counter + 1)
  end

  def get_whitespace_indexes(str)
    str.chars.each_index.select { |i| str[i] == ' ' }
  end

  def insert_whitespaces(str, indexes)
    array_s = str.chars
    indexes.each { |i| array_s.insert(i, ' ') }
    array_s.join
  end

  def remove_whitespaces(str)
    str.gsub(' ', '')
  end

  def rotate_str(str, n)
    str.chars.rotate(n).join
  end

  def rotate_str_right(str, n)
    rotate_str(str, -n)
  end

  def rotate_str_left(str, n)
    rotate_str(str, n)
  end
end
