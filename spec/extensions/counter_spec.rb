require 'spec_helper'

describe NonSharedAccessors do

  it 'should count by rule' do

    array = [ '2', 2, 5, '8', 7, 3, 6, 1, 11 ]

    expect(array.count_by_rule{|x| x.to_s == ?2 }).to eq({
      true => 2,
      false => 7
    })

    expect(array.count_by_rule{|x| x == 2 }).to eq({
      true => 1,
      false => 8
    })

    expect(array.count_by_rule{|x| x.to_i % 2 == 0 }).to eq({
       true => 4,
       false => 5
    })

    expect(array.count_by_rule{|x| x.to_s.include?(?1) }).to eq({
        true => 2,
        false => 7
    })

  end

end
