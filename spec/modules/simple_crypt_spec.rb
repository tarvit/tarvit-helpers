require 'spec_helper'

describe SimpleCrypt do

  it 'should crypt/decrypt by secret key' do
    key = 'very_secret-key'
    @sc = SimpleCrypt.new(key)

    original_word = 'WORD'
    result = @sc.encrypt(original_word)

    expect(result).to eq("w88LiGPM279AZCpOZvyF2w==\n")
    expect(@sc.decrypt(result)).to eq(original_word)
  end

end