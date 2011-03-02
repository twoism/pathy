require 'json'

module Pathy
  module InstanceMethods
    def at_json_path path
      method_chain = path.split('.')
      method_chain.inject(self.reparsed_as_json) {|obj,m| obj.send('[]', (obj.respond_to?(:push) ? m.to_i : m) ) }
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

