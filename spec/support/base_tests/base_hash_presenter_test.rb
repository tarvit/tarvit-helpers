module BaseHashPresenterTest

  def test_presenter(hash_presenter)

    it 'should present a flat hash' do
      hp = hash_presenter.new(a: 1, b: 2, 'c' => [ 3 ] )
      expect(hp.a).to eq(1)
      expect(hp.b).to eq(2)
      expect(hp.c).to eq([ 3 ])
      expect(->{ hp.d }).to raise_error(NoMethodError)
      expect(hp._hash.values).to eq([1, 2, [3]])
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

    it 'should detect root node' do
      hp = hash_presenter.new(a: { b: { c: 1 }, d: { e: 2 } } )
      expect(hp._root?).to be_truthy
      expect(hp.a.b._root?).to be_falsey
      expect(hp.a.d._root?).to be_falsey
    end
  end
end
