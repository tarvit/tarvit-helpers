describe HashPresenter::Cached do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::Cached)

  context 'Special Behavior' do

    it 'should not depend on an attribute object' do
      original = { a: 2 }
      hp = HashPresenter::Cached.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(2)
    end

    it 'should not calculate result for a nested hash twice' do
      hp = HashPresenter::Cached.new(a: { b: 1 })
      expect(hp.a.object_id).to eq(hp.a.object_id)
    end
  end
end
