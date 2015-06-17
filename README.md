**tarvit-helpers**

Simple helpers for Ruby.
Non Shared Accessors
Ruby language has a specific behavior of class variables. They are shared among all subclasses.

```ruby
As result they behave like that:
class A
  cattr_accessor :value
end

class B < A

end

A.value
=> nil
B.value
=> nil

A.value = 2
B.value = 3

A.value
=> 3
B.value
=> 3
```

== Contributing to tarvit-helpers
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2015 Vitaly Tarasenko. See LICENSE.txt for
further details.

