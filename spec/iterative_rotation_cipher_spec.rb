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
      [10, 'If you wish to make an apple pie from scratch, you must first invent the universe.'],
      [14, 'True evil is a mundane bureaucracy.'],
      [22, 'There is nothing more atrociously cruel than an adored child.'],
      [36,
       "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"],
      [29,
       "I avoid that bleak first hour of the working day during which my still sluggish senses and body make every chore a penance.\nI find that in arriving later, the work which I do perform is of a much higher quality."]
    ]
  end

  let(:decode_examples) do
    [
      '10 hu fmo a,ys vi utie mr snehn rni tvte .ysushou teI fwea pmapi apfrok rei tnocsclet',
      '14 daue ilev is a munbune Traurecracy.',
      '22 tareu oo iucnaTr dled oldthser.hg hiarm nhcn se rliyet oincoa',
      "36 ws h weA dgIaa ug owh n!asrit git \n msm phw teaI'e tanantwhe reos\ns ther! aHeae 'gwadin\nt haw n htoo ,I'i sy aohOy",
      "29 a r.lht niou gwryd aoshg gIsi mk lei adwhfci isd seensn rdohy mo kleie oltbyhes a\naneu p.n rndr tehh irnne yifav t eo,raclhtc frpw IIti im gwkaidhv aicufh ima doea eruhi y io qshhcoa kr ef l btah gtrrse otnvugrt"

    ]
  end

  it('Encoding') do
    encode_examples.zip(decode_examples).each do |(number, string), expected|
      # binding.pry
      expect(irc.encode(number, string)).to eq(expected)
    end
  end

  xit 'has indices and spaceless string' do
    decode = "36 er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    ind = irc.decode(decode)
    # expect(num).to eq(36)
    # expect(str).to eq("ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth")
    expect(ind).to eq([2, 4, 8, 14, 17, 21, 29, 33, 35, 39, 43, 50, 60, 67, 73, 79, 89, 93, 95, 100, 105, 108])
  end

  xit 'shift the order of characters for each space-separated substring to the left by N:' do
    decode = "36 er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    result = irc.decode(decode)
    sub_encoded = "er e aga intod ay ,\nO hhowIwi shh e 'dg oaw ay!AsI wasgoingu pthest air\nI metam anwhowasn 'tt h ere! \nHew as n'tth"
    expect(result).to eq(sub_encoded)
  end

  xit 'remove spaces' do
    decode = "36 er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    result = irc.decode(decode)
    sub_encoded = "ereagaintoday,\nOhhowIwishhe'dgoaway!AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tth"
    expect(result).to eq(sub_encoded)
  end

  xit 'Step 2i shift the order of string characters to the left by N:' do
    decode = "36 er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    result = irc.decode(decode)
    sub_encoded = "AsIwasgoingupthestair\nImetamanwhowasn'tthere!\nHewasn'tthereagaintoday,\nOhhowIwishhe'dgoaway!"
    expect(result).to eq(sub_encoded)
  end

  xit 'Step x add back the spaces' do
    decode = "36 er e aga dinto ay ,\nO ihhowIw shh e 'dg oaw ay!AsI wasgoingu pthest Iair\n mmeta anwhowasn 'tt h ere! \nHew as hn'tt"
    result = irc.decode(decode)
    sub_encoded = "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"
    expect(result).to eq(sub_encoded)
  end
  # ==============================================================
  xit 'simple encode' do
    num = 1
    enc = "12345"
    # Step 1 — remove all spaces:
    deco = "12345"
    # Step 2 — shift the order of string characters to the right by num:
    deco = "51234"
    # Step 3 — place the spaces back in their original positions:
    deco = "51234"
    # Step 4 — shift the order of characters for each space-separated substring to the right by 1:
    deco = "45123"
    # Step +1 preppend num
    deco = "1 45123"

    # answer = irc.encode(num, enc)
    # expect(answer).to eq(deco)

    answer = irc.decode(deco)
    expect(answer).to eq(enc)
  end

  it('Decoding') {
    decode_examples.zip(encode_examples).each do |str, (number, expected)|
      # number
      # => 36

      # string
      # => "As I was going up the stair\nI met a man who wasn't there!\nHe wasn't there again today,\nOh how I wish he'd go away!"

      # expected
      # => "36 ws h weA dgIaa ug owh n!asrit git \n msm phw teaI'e tanantwhe reos\ns ther! aHeae 'gwadin\nt haw n htoo ,I'i sy aohOy"
      # binding.pry
      expect(irc.decode(str)).to eq(expected)
    end
  }
end
