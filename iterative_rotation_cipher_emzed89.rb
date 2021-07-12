# frozen_string_literal: true

class IterativeRotationCipherEmzed89
  def encode(n, s)
    binding.pry
    p s
    space = s.chars.map.with_index { |c, i| c == ' ' ? i : -1 }.select(&:positive?)
    n.times do
      e = s.delete(' ')
      e = e[-(n % e.size), n % e.size] + e[0, e.size - (n % e.size)]
      e = (0...s.size).map { |i| (space.include? i) ? ' ' : e[i - space.select { |n| n < i }.count] }.join
      s = e.split(/ /).map do |i|
        i.size.positive? ? i[-(n % i.size), n % i.size] + i[0, i.size - (n % i.size)] : ''
      end.join(' ')
    end
    "#{n} #{s}"
  end

  def decode(s)
    n, s = s.split(' ', 2)
    n = n.to_i
    space = s.chars.map.with_index { |c, i| c == ' ' ? i : -1 }.select(&:positive?)
    n.times do
      e = s.split(/ /).map do |i|
        i.size.positive? ? i[n % i.size, i.size - (n % i.size)] + i[0, n % i.size] : ''
      end.join(' ').delete(' ')
      e = e[n % e.size, e.size - (n % e.size)] + e[0, n % e.size]
      s = (0...s.size).map { |i| (space.include? i) ? ' ' : e[i - space.select { |n| n < i }.count] }.join
    end
    s
  end
end
