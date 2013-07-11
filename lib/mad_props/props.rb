class MadProps::Props

  def initialize(hash={})
    raise ArgumentError.new 'not a hash' unless hash.is_a?(Hash)
    hash.each do |key,value|
      self.class.validate_key!(key)
      self.class.validate_value!(value)
      self.class.define_getter(key)
      self.class.define_setter(key, value)
      instance_variable_set("@#{key}", value)
    end
  end

  private

  def self.validate_key!(key)
    # can't include reserve names
    # can't use (), {}, = or .
  end

  def self.validate_value!(value)
  end

  def self.define_getter(key)
    define_method(key) do
      instance_variable_get("@#{key}")
      # NOTE:  This is where the recursive lookup will occur
    end
  end

  def self.define_setter(key, value)
    define_method("#{key}=") do
      validate_value!(value)
      instance_variable_set("@#{key}", value)
    end

  end


end
