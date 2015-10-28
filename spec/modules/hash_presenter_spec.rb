require 'spec_helper'

describe HashPresenter do

  it 'should present hashes' do
    hp = HashPresenter.present({ a: 1 })
    expect(hp.a).to eq(1)
  end

  it 'should not accept not Hashes' do
    expect(->{
      HashPresenter.present('Hash').to raise_error(ArgumentError)
    })
  end

  it 'should get an observable presenter' do
    hp = HashPresenter.present({  }, :observable)
    expect(hp).to be_a(HashPresenter::Observable)
  end

  it 'should get a cached presenter' do
    hp = HashPresenter.present({  }, :cached)
    expect(hp).to be_a(HashPresenter::Cached)
  end

end
