module Gdbcompiler
  # Class for script parsing
  class Script
    attr_accessor(
      :raw,
      :values
    )

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @raw = @raw.to_s.strip
      @values ||= []
      map_raw_to_values
    end

    private

    def map_raw_to_values
      stripped_raw = @raw.gsub(/\A{( +)?/, '').gsub(/( +)?}\z/, '')
      effects = stripped_raw.split(';')
      effects.each do |effect|
        @values << Effect.new(raw: effect)
      end
    end
  end
end
