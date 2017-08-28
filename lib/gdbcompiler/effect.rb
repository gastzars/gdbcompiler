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
      splitted = @raw.split(' ')
      @type = splitted.count <= 1 ? @raw.match(/(^.*)\(/).to_s.delete('(').delete(')') : @raw.split(' ')[0]
    end

    def map_raw_to_variables
      splitted = @raw.split(' ')
      return false if splitted.count.zero?
      temp = splitted.count <= 1 ? @raw.match(/\((.*)\)/).to_s.delete('(').delete(')') : splitted[1..splitted.count].join(' ')
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

    def get_time_text_from_second(second)
      minute = second / 60
      second = second % 60
      hour = minute / 60
      minute = minute % 60
      day = hour / 24
      hour = hour % 24
      second_text = second.to_s + ' ' + TRANSLATE['time']['second'] if second > 0
      minute_text = minute.to_s + ' ' + TRANSLATE['time']['minute'] if minute > 0
      hour_text = hour.to_s + ' ' + TRANSLATE['time']['hour'] if hour > 0
      day_text = day.to_s + ' ' + TRANSLATE['time']['day'] if day > 0
      [day_text, hour_text, minute_text, second_text].compact.join(' ')
    end

    def sc_start(status, time, value = nil, rate = nil, flag = nil)
      if (value.nil? || value == '0') && rate.nil? && flag.nil?
        base_text = TRANSLATE['sc_start'][1]
        status_text = TRANSLATE['sc_start']['effect'][status]
        time_text = get_time_text_from_second(time.to_i / 1000)
        base_text.gsub('%1', status_text).gsub('%2', time_text)
      elsif (value.nil? || value == '0') && (!rate.nil? && rate != '0')
        status_text = TRANSLATE['sc_start']['effect'][status]
        time_text = get_time_text_from_second(time.to_i / 1000)
        rate_text = rate.to_i / 100
        base_text = TRANSLATE['sc_start'][2]
        base_text.gsub('%1', status_text).gsub('%2', time_text).gsub('%3', rate_text.to_s)
      else
        raise 'wtf case'
      end
    end

    def itemskill(skill, level)
      basetext = TRANSLATE['itemskill'][0]
      skill = TRANSLATE['itemskill']['skills'][skill.delete('"')]
      basetext.gsub('%1', skill).gsub('%2', level)
    end

    def getrandgroupitem(group_item, amount)
      basetext = TRANSLATE['getrandgroupitem'][0]
      group_item_name = TRANSLATE['getrandgroupitem']['groupitem'][group_item]
      basetext.gsub('%1', amount).gsub('%2', group_item_name)
    end

    def monster(_unused1, _unused2, _unused3, _unused4, monster_type, _unused6, _unused7)
      basetext = TRANSLATE['monster'][0]
      monster_type_text = TRANSLATE['monster']['types'][monster_type]
      basetext.gsub('%1', monster_type_text)
    end

    def sc_end(status)
      TRANSLATE['sc_end'].gsub('%1', TRANSLATE['status'][status].to_s)
    end

    def itemheal(hp, sp)
      text = []
      text << TRANSLATE['itemheal']['hp'].gsub('%1', eval(hp).to_s) if hp != '0'
      text << TRANSLATE['itemheal']['sp'].gsub('%1', eval(sp).to_s) if sp != '0'
      text.join("\n")
    end

    def percentheal(hp, sp)
      text = []
      text << TRANSLATE['percentheal']['hp'].gsub('%1', eval(hp).to_s) if hp != '0'
      text << TRANSLATE['percentheal']['sp'].gsub('%1', eval(sp).to_s) if sp != '0'
      text.join("\n")
    end

    def produce(item_type)
      base_text = TRANSLATE['produce'][0]
      item_type_text = TRANSLATE['produce']['item_type'][item_type]
      base_text.gsub('%1', item_type_text)
    end

    def rand(min, max)
      "#{min} ~ #{max}"
    end
  end
end
