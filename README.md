**tarvit-helpers**

Simple helpers for Ruby.

**Non Shared Accessors**

Ruby language has a specific behavior of class variables. They are shared among all subclasses.

As result they behave like that:
```ruby
class A
  cattr_accessor :value
end

class B < A

end

A.value = 2

A.value
=> 2
B.value
=> 2

B.value = 3

A.value
=> 3
B.value
=> 3
```
NonSharedAccessors module allows to create non shared accessors.
```ruby
class A
  include NonSharedAccessors
  non_shared_cattr_accessor :value
end

class B < A

end

A.value = 2

A.value
=> 2
B.value
=> nil

B.value = 3

A.value
=> 2
B.value
=> 3
```

HashPresenter module allows to present hashes as pure ojects.
```ruby
hp = HashPresenter.present({ a: 1, b: 2 })
hp.a
=> 1
hp.b
=> 2

original = { a: 1, b: 2 }
observer = HashPresenter.present(original, :observable)
observer.a
=> 1
original[:a] = 3
observer.a
=> 3


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
presenter = HashPresenter::CustomHashPresenter.new(@hash) do |rules|
  rules.when([ :user, :date ]) do |value|
    Date.parse(value)
  end

  rules.when([ :user, :age ]){|age| age.to_i }
  rules.when([ :user, :posts, :title ]){|title| title.capitalize }
end

presenter.user.date.class
=> Date
presenter.user.age
=> 11
presenter.user.posts[0].title
=> "Some title"


@hash = {
    accounts: [
        {
            :id => 1,
            :name => :director,
            collections: [
                {
                    :id => 42,
                    :name => :test_collection,
                }
            ]
        }
    ]
}

class AccountsPresenter < HashPresenter::CustomHashPresenter

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
  end
end

@presenter = AccountsPresenter.new(@hash)

account = @presenter.accounts.first
account.id
=> 1
account.name
=> 'director'
account.website
=> 'www.johndoe.com/director'
account.collections[0].name
=> 'TestCollection'
account.collections[0].folder
=> 'folders/TestCollection'

```


**Contributing to tarvit-helpers**
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

**Copyright**

Copyright (c) 2015 Vitaly Tarasenko. See LICENSE.txt for
further details.

