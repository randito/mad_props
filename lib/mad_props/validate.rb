
module Validate

  def validate!(key,value)
    validate_key!(key)
    validate_value!(value)
  end
  
  def invalid_key_chars
    @invalid_key_chars ||= %w{ ( ) ; = \{ \} : & - }
  end

  def reserved_keys
    @reserved_keys ||= Object.new.methods.map(&:to_s)
  end

  def validate_key!(key)
    invalid_key_chars.each do |invalid_char|
      raise ArgumentError.new("Invalid key: #{key}") if key.to_s.index(invalid_char)
    end
    raise ArgumentError.new("Reserved key: #{key}") if reserved_keys.include?(key.to_s)
  end

  def validate_value!(value)
  end


end
