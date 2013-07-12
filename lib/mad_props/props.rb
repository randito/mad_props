require 'mad_props/validate'
require 'active_support/core_ext/hash/indifferent_access'

class MadProps::Props

  extend Validate

  def initialize(hash={})
    raise ArgumentError.new 'not a hash' unless hash.is_a?(Hash)
    hash.each { |key,value| self.class.validate!(key, value) }
    @hash = hash.with_indifferent_access
  end

  def add_property(key, value)
    self.class.validate!(key, value)
    @hash[key] = value
  end

  def remove_property(key)
    @hash.delete(key)
  end

  def properties
    @hash.keys.map(&:to_sym)
  end

  def respond_to?(method)
    key = method.to_s.sub(/=/,'')
    return true if @hash.has_key?(key)
    super(method)
  end

  private

  def get_value(key)
    @hash[key]
  end

  def set_value(key,value)
    self.class.validate_value!(value)
    @hash[key] = value
  end

  def method_missing(method, *args)
    m = method.to_s
    key = m.sub(/=/,'')
    if @hash.has_key?(key)
      if m.index('=')
        raise ArgumentError.new("Only one argument") if args.size != 1
        set_value(key, args.first)
      else
        get_value(key)
      end
    else
      super(method, args)
    end
  end

end
