require 'spec_helper'

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

    it "should parse 'hash.one' as {'two': 2}" do
      @obj.at_json_path('hash.one.two').should == 2
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

    it "should parse 'hash.one.two' as 2" do
      @json.at_json_path('hash.one.two').should == 2
    end

  end
end

