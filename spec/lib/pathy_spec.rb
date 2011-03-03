require 'spec_helper'

describe Pathy do

  describe "pathy scope" do

    describe "Object.new" do
      it "should not respond to :has_json_path?" do
        Object.new.should_not respond_to(:has_json_path?)
      end
    end

    describe "SampleClass" do
      before :all do
        SampleClass.pathy!
      end

      it "should not respond to :has_json_path?" do
        Object.new.should_not respond_to(:has_json_path?)
      end

      it "should respond to :has_json_path?" do
        SampleClass.new.should respond_to(:has_json_path?)
      end

    end

  end

  before :all do
    
    @json = %[ 
      {
        "string"  : "barr",
        "number"  : 1,
        "array"   : [1,2,3],
        "hash"    : {"one":{"two" : 2}},
        "bool"    : false,
        "nullval" : null
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
      Object.pathy!

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

      it "should have 'bool'" do
        @obj.should have_json_path 'bool'
      end
      
      it "should have 'nullval'" do
        @obj.should have_json_path 'nullval'
      end

      it "should be false for invalid paths" do
        @obj.has_json_path?('hash.one.does_not_exist').should be_false
      end

      it "should work as rspec matcher" do
        @obj.should have_json_path "hash.one"
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

