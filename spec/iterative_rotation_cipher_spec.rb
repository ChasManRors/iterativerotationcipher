# frozen_string_literal: true

# create your sample spec in the root/spec dir
require 'spec_helper'
require_relative '../iterative_rotation_cipher'

#   let(:f) { IterativeRotationCipher.new }
#   let(:answers) { [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] }

#   context 'Stard - Given When Then' do
#     it 'returns expected iterative_rotation_cipher sequence' do
#       expect(answers).to eq((0..9).map { |num| f.iterative_rotation_cipher num })
#     end
#   end
# end

describe 'iterative_rotation_cipher' do
  let(:irc) { IterativeRotationCipher.new }

  let(:encode_examples) do
    [
      # [10, "If you wish to make an apple pie from scratch, you must first invent the universe."],
      # [14, "True evil is a mundane bureaucracy."],
      # [22, "There is nothing more atrociously cruel than an adored child."],
      
      [36,
        "air\nI!"],
        

      # [36,
      #  "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"],

      [29,
       "I avoid that bleak first hour of the working day during which my still sluggish senses and body make every chore a penance.\nI find that in arriving later, the work which I do perform is of a much higher quality."]
    ]
  end

  let(:decode_examples) do
    [
      # "10 hu fmo a,ys vi utie mr snehn rni tvte .ysushou teI fwea pmapi apfrok rei tnocsclet",
      # "14 daue ilev is a munbune Traurecracy.",
      # "22 tareu oo iucnaTr dled oldthser.hg hiarm nhcn se rliyet oincoa",
      "36 ws h weA dgIaa ug owh n!asrit git \n msm phw teaI'e tanantwhe reos\ns ther! aHeae 'gwadin\nt haw n htoo ,I'i sy aohOy",
      "29 a r.lht niou gwryd aoshg gIsi mk lei adwhfci isd seensn rdohy mo kleie oltbyhes a\naneu p.n rndr tehh irnne yifav t eo,raclhtc frpw IIti im gwkaidhv aicufh ima doea eruhi y io qshhcoa kr ef l btah gtrrse otnvugrt"
    ]
  end

  it('Encoding') {
    binding.pry
    encode_examples.zip(decode_examples).each do |(number, string), expected|
      expect(irc.encode(number, string)).to eq(expected)
    end
  }
  xit('Decoding') do
    decode_examples.zip(encode_examples).each do |string, (_number, expected)|
      expect(irc.decode(string)).to eq(expected)
    end
  end
end
