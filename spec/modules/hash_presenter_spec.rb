require 'spec_helper'

module BaseHashPresenterTest

  def test_presenter(hash_presenter)

    it 'should present a flat hash' do
      hp = hash_presenter.new(a: 1, b: 2, 'c' => [ 3 ] )
      expect(hp.a).to eq(1)
      expect(hp.b).to eq(2)
      expect(hp.c).to eq([ 3 ])
      expect(->{ hp.d }).to raise_error(NoMethodError)
    end

    it 'should transform complex keys' do
      hp = hash_presenter.new('A very big key' => :value)
      expect(hp.a_very_big_key).to eq(:value)
    end

    it 'should present nested hashes' do
      hp = hash_presenter.new(a: { b: 1, c: { d: 2 } })
      expect(hp.a).to be_a(hash_presenter)
      expect(hp.a.b).to eq(1)
      expect(hp.a.c.d).to eq(2)
    end

    it 'should present arrays with hashes' do
      hp = hash_presenter.new(a: [ { b: 1 }, { c: 2 }, 3 ])
      expect(hp.a[0].b).to eq(1)
      expect(hp.a[1].c).to eq(2)
      expect(hp.a[2]).to eq(3)
    end
  end
end

describe HashPresenter::SimpleHashPresenter do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::SimpleHashPresenter)

  context 'Special Behavior' do

    it 'should not depend on attribute object' do
      original = { a: 2 }
      hp = HashPresenter::SimpleHashPresenter.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(2)
    end

    it 'should regenerate method result for nested hash' do
      hp = HashPresenter::SimpleHashPresenter.new(a: { b: 1 })
      expect(hp.a.object_id).to_not eq(hp.a.object_id)
    end
  end
end

describe HashPresenter::CachedHashPresenter do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::CachedHashPresenter)

  context 'Special Behavior' do

    it 'should not depend on attribute object' do
      original = { a: 2 }
      hp = HashPresenter::CachedHashPresenter.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(2)
    end

    it 'should not calculate result for nested hash twice' do
      hp = HashPresenter::CachedHashPresenter.new(a: { b: 1 })
      expect(hp.a.object_id).to eq(hp.a.object_id)
    end
  end
end


describe HashPresenter::ObservableHashPresenter do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::ObservableHashPresenter)

  context 'Special Behavior' do

    it 'should observe an attribute object' do
      original = { a: 2 }
      hp = HashPresenter::ObservableHashPresenter.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(3)

      original[:a] = { b: 1 }

      expect(hp.a.b).to eq(1)

      original[:c] = 4

      expect(hp.c).to eq(4)
    end

    it 'should regenerate method result for nested hash' do
      hp = HashPresenter::ObservableHashPresenter.new(a: { b: 1 })
      expect(hp.a.object_id).to_not eq(hp.a.object_id)
    end
  end
end

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
    expect(hp).to be_a(HashPresenter::ObservableHashPresenter)
  end

  it 'should get a cached presenter' do
    hp = HashPresenter.present({  }, :cached)
    expect(hp).to be_a(HashPresenter::CachedHashPresenter)
  end


end
