### Pathy ###

  JSON validation helper.

### Installation ###

    gem install pathy

  In Rails

    gem 'pathy'  

### Usage ###

  Activate pathy for all objects

    Object.pathy!

  This adds the conveinece methods to any object

```ruby
@obj = %[ 
  {
    "string"  : "barr",
    "number"  : 1,
    "array"   : [1,2,3],
    "hash"    : {"one":{"two" : 2}}
    }
]

puts @obj.at_json_path("number")
=> 1
puts @obj.at_json_path('array')
=> [1,2,3]
@json.at_json_path('hash.one')
=> {'two' => 2}
```

###RSpec Matcher###

```ruby
it "should work as rspec matcher" do
  @obj.should have_json_path "hash.one"
end
```


##Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Christopher Burnett. See LICENSE for details.
