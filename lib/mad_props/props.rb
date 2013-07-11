class MadProps::Props

  def initialize(hash={})
    raise ArgumentError.new 'not a hash' unless hash.is_a?(Hash)
    @properties = []
    hash.each do |key,value|
      add_property(key, value)
    end
  end

  def add_property(key, value)
    self.class.validate_key!(key)
    self.class.validate_value!(value)
    self.class.define_getter(key)
    self.class.define_setter(key, value)
    instance_variable_set("@#{key}", value)
    @properties << key.to_sym
  end

  def properties
    @properties.dup
  end

  private

  def self.reserved_keys
    @reserved_keys ||= Object.new.methods.map(&:to_s)
  end

  def self.invalid_key_chars
    @invalid_key_chars ||= %w{ ( ) ; = \{ \} : & - }
  end

  def self.validate_key!(key)
    invalid_key_chars.each do |invalid_char|
      raise ArgumentError.new("Invalid key: #{key}") if key.to_s.index(invalid_char)
    end
    raise ArgumentError.new("Reserved key: #{key}") if reserved_keys.include?(key.to_s)
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
    define_method("#{key}=") do |value|
      self.class.validate_value!(value)
      instance_variable_set("@#{key}", value)
    end

  end

end
