require 'spec_helper'

describe HashPresenter do

  it 'should present a flat hash' do
    hp = HashPresenter.new(a: 1, b: 2, 'c' => [ 3 ] )
    expect(hp.a).to eq(1)
    expect(hp.b).to eq(2)
    expect(hp.c).to eq([ 3 ])
    expect(->{ hp.d }).to raise_error(NoMethodError)
  end

  it 'should transform complex keys' do
    hp = HashPresenter.new('A very big key' => :value)
    expect(hp.a_very_big_key).to eq(:value)
  end

  it 'should present nested hashes' do
    hp = HashPresenter.new(a: { b: 1, c: { d: 2 } })
    expect(hp.a).to be_a(HashPresenter)
    expect(hp.a.b).to eq(1)
    expect(hp.a.c.d).to eq(2)
  end

  it 'should present arrays with hashes' do
    hp = HashPresenter.new(a: [ { b: 1 }, { c: 2 }, 3 ])
    expect(hp.a[0].b).to eq(1)
    expect(hp.a[1].c).to eq(2)
    expect(hp.a[2]).to eq(3)
  end

end
