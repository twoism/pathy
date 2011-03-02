### Pathy ###

  JSON validation helper.

### Installation ###

    gem install pathy

### Usage ###

    describe Pathy do
      before :all do

        Object.pathy!

        @json = %[ 
          {
            "string"  : "barr",
            "number"  : 1,
            "array"   : [1,2,3],
            "hash"    : {"one":{"two" : 2}}
            }
        ]

        @json_array = %[ 
          [{
            "string"  : "barr",
            "number"  : 1,
            "array"   : [1,2,3],
            "hash"    : {"one":{"two" : 2}}
          }]
        ]

      end


      describe "for hashes" do
        before :all do
          @obj    = JSON.parse(@json)
          @array  = JSON.parse(@json_array)
        end

        it "should parse 'number' as 1" do
          @obj.at_json_path("number").should == 1
        end

        it "should parse 'array' as [1,2,3]" do
          @obj.at_json_path('array').should == [1,2,3]
        end

        it "should parse 'hash.one' as {'two' => 2}" do
          @json.at_json_path('hash.one').should == {'two' => 2}
        end

        it "should parse 'hash.one' as {'two': 2}" do
          @obj.at_json_path('hash.one.two').should == 2
        end

        describe "invalid paths" do
          it "should raise InvalidPathError" do
            lambda { 
              @obj.at_json_path('foo.bar')
            }.should raise_error Pathy::InvalidPathError
          end
        end

        describe "#has_json_path?" do
          it "should be true for valid paths" do
            @obj.has_json_path?('hash.one.two').should be_true
          end
          it "should be false for invalid paths" do
            @obj.has_json_path?('hash.one.foo').should be_false
          end

        end


      end

      describe "for arrays" do

        before :all do
          @array  = JSON.parse(@json_array)
        end

        it "should find the index" do
          @array.at_json_path('0.hash.one.two').should == 2
        end

      end

      describe "for json strings" do

        it "should parse 'number' as 1" do
          @json.at_json_path("number").should == 1
        end

        it "should parse 'array' as [1,2,3]" do
          @json.at_json_path('array').should == [1,2,3]
        end

        it "should parse 'hash.one' as {'two' => 2}" do
          @json.at_json_path('hash.one').should == {'two' => 2}
        end

        it "should parse 'hash.one.two' as 2" do
          @json.at_json_path('hash.one.two').should == 2
        end

      end

    end
    

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