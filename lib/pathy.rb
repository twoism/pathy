require 'json'

module Pathy

  InvalidPathError = Class.new(NoMethodError)

  module InstanceMethods

    # returns the value parsed from JSON at a given path.
    # Example:
    # {:some_key => {:nested_key => 'awesome'}}.at_json_path('some_key.nested_key')
    # returns 'awesome'
    def at_json_path path
      path.split('.').inject( reparsed_from_json ) do |reparsed_self, method| 

        is_array_like     = reparsed_self.respond_to?(:push)
        key_or_index      = is_array_like ? method.to_i : method
        has_key_or_index  = is_array_like ? !reparsed_self.slice(key_or_index).nil? : reparsed_self.keys.include?(key_or_index)

        raise InvalidPathError, "Could not resolve #{path} at #{key_or_index}" unless has_key_or_index

        reparsed_self.send '[]', key_or_index
      end
    end

    # returns true if the path is found. Provides usage in Rspec
    # Example in rspec:
    # {:some_key => {:nested_key => 'awesome'}}.should have_json_path('some_key.nested_key')
    def has_json_path? path
      begin
        at_json_path path
        true
      rescue InvalidPathError
        false
      end
    end

    # returns the parsed JSON representation of an instance.
    # If the current instance is a string we assume it's JSON
    def reparsed_from_json
      self.is_a?(String) ? JSON.parse(self) : JSON.parse(self.to_json)
    end    
  end
  module ClassMethods

    # adds pathy methods to a Class
    def pathy!
      self.send :include, InstanceMethods
    end
  end
end

Object.extend Pathy::ClassMethods

