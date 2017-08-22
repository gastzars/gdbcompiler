module Gdbcompiler
  # Class condition for script
  class Condition
    attr_accessor(
      :raw,
      :conditions
    )

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end
  end
end
