describe HashPresenter::Observable do

  extend BaseHashPresenterTest
  test_presenter(HashPresenter::Observable)

  context 'Special Behavior' do

    it 'should observe an attribute object' do
      original = { a: 2 }
      hp = HashPresenter::Observable.new(original)

      expect(hp.a).to eq(2)

      original[:a] = 3

      expect(hp.a).to eq(3)

      original[:a] = { b: 1 }

      expect(hp.a.b).to eq(1)

      original[:c] = 4

      expect(hp.c).to eq(4)
    end

    it 'should regenerate method result for a nested hash' do
      hp = HashPresenter::Observable.new(a: { b: 1 })
      expect(hp.a.object_id).to_not eq(hp.a.object_id)
    end
  end
end
