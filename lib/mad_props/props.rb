require 'mad_props/validate'

class MadProps::Props

  extend Validate

  def initialize(hash={})
    raise ArgumentError.new 'not a hash' unless hash.is_a?(Hash)
    @properties = []
    hash.each do |key,value|
      add_property(key, value)
    end
  end

  def add_property(key, value)
    self.class.validate!(key, value) # Validate module
    self.class.define_getter(key)
    self.class.define_setter(key, value)
    instance_variable_set("@#{key}", value)
    @properties << key.to_sym
  end

  def properties
    @properties.dup
  end

  private

  def self.define_getter(key)
    define_method(key) do
      instance_variable_get("@#{key}")
      # NOTE:  This is where the recursive lookup will occur
    end
  end

  def self.define_setter(key, value)
    define_method("#{key}=") do |value|
      self.class.validate_value!(value)
      instance_variable_set("@#{key}", value)
    end

  end

end
