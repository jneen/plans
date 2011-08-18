module Builders
  class Definition
    attr_reader :attrs

    def initialize(&builder)
      @builder = builder
    end

    def apply(record, attrs)
      @record = record
      @attrs = attrs.with_indifferent_access
      instance_eval(&@builder)
      @attrs.each { |k, v| @record.send :"#{k}=", v }
      @record
    end

    def method_missing(m, *a, &b)
      m_eq = :"#{m}="
      if a.size == 1
        @record.send(m_eq, a.first)
      elsif b
        @record.send(m_eq, @record.instance_eval(&b)) unless @attrs.key?(m)
      else
        super
      end
    end
  end

  def self.build(klass, opts={}, &definition)
    key = opts[:as] || name_of(klass)
    builders[key] = [klass, Definition.new(&definition)]
  end

  def self.builders
    @builders ||= HashWithIndifferentAccess.new
  end

  def self.name_of(klass)
    return klass unless klass.respond_to? :name

    # ActiveSupport's #underscore replaces :: with /, which is
    # no good for method names.
    klass.name.to_s.underscore.gsub /\//, '_'
  end

  def build(type, attrs={})
    type = Builders.name_of(type)

    raise ArgumentError, <<-msg.squish unless Builders.builders.key?(type)
      Couldn't find builder #{type.to_sym.inspect}
    msg

    klass, builder = Builders.builders[type]

    record = klass.new
    builder.apply(record, attrs)
    record.valid? # slight hack to run validators, which will
                  # do setup hooks, and also populate #errors
    record
  end
end

Dir.glob(File.expand_path('builders/**/*.rb', File.dirname(__FILE__))).each do |f|
  require f
end

include Builders
