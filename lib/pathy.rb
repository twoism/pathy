require 'json'

module Pathy
  InvalidPathError = Class.new(NoMethodError)

  module InstanceMethods
    def at_json_path path
      method_chain = path.split('.')
      method_chain.inject(self.reparsed_as_json) do |obj,m| 
        key         = (obj.respond_to?(:push) ? m.to_i : m)
        new_object  = obj.send('[]', key) 

        raise InvalidPathError, "Could not resolve #{path} at #{key}" if obj[key].nil?
        new_object
       end
    rescue 
      raise InvalidPathError, "Could not resolve #{path}"
    end

    def has_json_path? path
      begin
        value = self.at_json_path(path)
        return true
      rescue InvalidPathError
        false
      end
    end

    def reparsed_as_json
      self.is_a?(String) ? JSON.parse(self) : JSON.parse(self.to_json)
    end    
  end
  module ClassMethods
    def pathy!
      self.send :include, InstanceMethods
    end
  end
end

Object.extend Pathy::ClassMethods

