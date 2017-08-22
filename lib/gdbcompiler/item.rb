module Gdbcompiler
  # Item class for parsing item from database
  class Item
    attr_accessor(
      :id,
      :aegis_name,
      :name,
      :type,
      :buy,
      :sell,
      :weight,
      :attack,
      :def,
      :range,
      :slot,
      :job,
      :class,
      :gender,
      :loc,
      :wlv,
      :elv,
      :refineable,
      :view,
      :script,
      :on_equip_script,
      :on_unequip_script
    )

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @script = Script.new(raw: @script)
      @on_equip_script = Script.new(raw: @on_equip_script)
      @on_unequip_script = Script.new(raw: @on_unequip_script)
    end
  end
end
