require 'json'

module Pathy

  InvalidPathError = Class.new(NoMethodError)

  module InstanceMethods

    # returns the value parsed from JSON at a given path.
    # Example:
    # {:some_key => {:nested_key => 'awesome'}}.at_json_path('some_key.nested_key')
    # returns 'awesome'
    def at_json_path path
      method_chain = path.split('.')
      method_chain.inject(self.reparsed_as_json) do |obj,m| 
        key         = (obj.respond_to?(:push) ? m.to_i : m)
        new_value   = obj.send('[]', key) 

        raise InvalidPathError, "Could not resolve #{path} at #{key}" if obj[key].nil?

        new_value
       end
    rescue 
      raise InvalidPathError, "Could not resolve #{path}"
    end

    # returns true if the path is found. Provides usage in Rspec
    # Example in rspec:
    # {:some_key => {:nested_key => 'awesome'}}.should have_json_path('some_key.nested_key')
    def has_json_path? path
      begin
        self.at_json_path(path)
        true
      rescue InvalidPathError
        false
      end
    end

    # returns the parsed JSON representation of an instance.
    # If the current instance is a string we assume it's JSON
    def reparsed_as_json
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

