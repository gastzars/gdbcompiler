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

    # Translate to thai
    def translate
      send(@type, *@variables)
    end

    private

    def map_raw_to_type
      @type = @raw.split(' ')[0]
    end

    def map_raw_to_variables
      splitted = @raw.split(' ')
      return false if splitted.count.zero?
      temp = splitted[1..splitted.count].join(' ')
      index = 0
      found = false
      vars = temp.chars.collect do |u|
        if (u == '{' || u == '(') && index != -1
          found = true
          index += 1
          u
        elsif (u == '}' || u == ')') && index != -1
          index -= 1
          u
        elsif (u != '{' || u != '(') && index.zero?
          u == ',' ? 'parse_item_script' : u
        else
          u
        end
      end.join.split('parse_item_script')
      vars.each do |var|
        @variables << var
      end
    end

    # RATHENA SCRIPT

    def itemheal(hp, sp)
      text = []
      text << TRANSLATE['itemheal']['hp'].gsub('%1', eval(hp).to_s) if hp != '0'
      text << TRANSLATE['itemheal']['sp'].gsub('%1', eval(sp).to_s) if sp != '0'
      text.join("\n")
    end

    def rand(min, max)
      "#{min} ~ #{max}"
    end
  end
end
