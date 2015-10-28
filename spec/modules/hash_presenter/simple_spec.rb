describe HashPresenter::Simple do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::Simple)

  context 'Special Behavior' do

    it 'should not depend on an attribute object' do
      original = { a: 2 }
      hp = HashPresenter::Simple.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(2)
    end

    it 'should regenerate method result for a nested hash' do
      hp = HashPresenter::Simple.new(a: { b: 1 })
      expect(hp.a.object_id).to_not eq(hp.a.object_id)
    end
  end
end
