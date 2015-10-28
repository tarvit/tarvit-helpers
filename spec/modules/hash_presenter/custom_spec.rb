describe HashPresenter::Custom do
  extend BaseHashPresenterTest
  test_presenter(HashPresenter::Custom)

  context 'Special Behavior' do
    before :each do
      @hash = {
          user: {
              date: '11/11/2015',
              age: '11',
              address: [
                  'USA', 'NY', 'Ba Street'
              ],
              posts: [
                  { id: '1', title: 'some title' },
                  { id: '2', title: 'the other title' },
              ],
          }
      }
    end

    it 'should customize presenter' do
      presenter = HashPresenter::Custom.new(@hash) do |rules|
        rules.when([ :user, :date ]) do |value|
          Date.parse(value)
        end

        rules.when([ :user, :age ]){|age| age.to_i }
        rules.when([ :user, :posts, :title ]){|title| title.capitalize }
        rules.when([ :user, :address ]){|list| list.join(?/) }
      end

      expect(presenter.user.date).to eq(Date.new(2015, 11, 11))
      expect(presenter.user.age).to eq(11)
      expect(presenter.user.address).to eq('USA/NY/Ba Street')
      expect(presenter.user.posts[0].title).to eq('Some title')
    end

    it 'should declare nested presenters' do
      presenter = HashPresenter::Custom.new(@hash) do |rules|

        rules.when([ :user, :date ]) do |value|
          Date.parse(value)
        end

        rules.when([ :user, :posts ])do |posts|
          posts.map do |post|
            HashPresenter::Custom.new(post) do |post_rules|
              post_rules.when([ :title ]){|title| title.upcase }
            end
          end
        end
      end

      expect(presenter.user.date).to eq(Date.new(2015, 11, 11))
      expect(presenter.user.posts[0].title).to eq('SOME TITLE')
    end

    context 'Subclass' do
      before :all do
        @hash = {
            accounts: [
                {
                    :id => 1,
                    :name => :director,
                    collections: [
                        { :id => 42, :name => :test_collection },
                        { :id => 24, :name => :best_collection },
                    ]
                }
            ]
        }

        class AccountsPresenter < HashPresenter::Custom

          def _modify_hash(hash)
            res = super(hash)
            res[:extra] = :value
            res
          end

          def _add_rules(rules)
            rules.when([:accounts, :name]) do |value|
              value.to_s
            end

            rules.when([:accounts, :website]) do |value, object|
              'www.johndoe.com/' + object.name.to_s
            end

            rules.when([:accounts, :collections, :name]) do |value|
              value.to_s.camelize
            end

            rules.when([:accounts, :collections, :folder]) do |value, object|
              "folders/#{object.name}"
            end

            rules.when([:accounts, :collections, :global_folder]) do |value, object|
              "#{object._parent.name}/folders/#{object.name}"
            end
          end
        end

        @presenter = AccountsPresenter.new(@hash)
      end

      it 'should work as subclass' do
        account = @presenter.accounts.first
        expect(account.id).to eq(1)
        expect(account.name).to eq('director')
        expect(account.website).to eq('www.johndoe.com/director')
        expect(account.collections[0].name).to eq('TestCollection')
        expect(account.collections[0].folder).to eq('folders/TestCollection')
        expect(account.collections[1].name).to eq('BestCollection')
        expect(account.collections[1].folder).to eq('folders/BestCollection')
        expect(account.collections[1].global_folder).to eq('director/folders/BestCollection')

        expect(@presenter.extra).to eq(:value)

        expect(@presenter._custom_hash).to eq({
            :accounts => [
                {
                    :id=>1,
                    :name=>'director',
                    :collections=>[
                        {:id=>42, :name=>'TestCollection', :folder=>'folders/TestCollection', :global_folder=>'director/folders/TestCollection'},
                        {:id=>24, :name=>'BestCollection', :folder=>'folders/BestCollection', :global_folder=>'director/folders/BestCollection'},
                    ],
                    :website=>'www.johndoe.com/director'
                }
            ],
            :extra => :value,
        })
      end
    end
  end
end
