module Gdbcompiler
  # Class effeect for script effect
  class Effect
    attr_accessor(
      :raw,
      :type,
      :variables
    )

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @raw = @raw.to_s.strip
      @variables ||= []
      map_raw_to_type
      map_raw_to_variables
    end

    private

    def map_raw_to_type
      @type = @raw.split(' ')[0]
    end

    def map_raw_to_variables
      splitted = @raw.split(' ')
      temp = splitted[1..splitted.count].join(' ')
      vars = temp.split(',')
      vars.each do |var|
        @variables << var
      end
    end
  end
end
