module Gdbcompiler
  # Parser class for parsing text to instances
  class Parser
    attr_accessor(:version, :item_db, :mob_db)
    RENEWAL_PATH = 're'.freeze
    PRE_RENEWAL_PATH = 'pre-re'.freeze
    DATABASE_PATH = 'db'.freeze
    ITEM_DB_FILENAME = 'item_db.txt'.freeze
    MOB_DB_FILENAME = 'mob_db.txt'.freeze

    # When create an instance can be create with hash
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @version ||= RENEWAL_PATH
      @item_db ||= item_db_path
      @mob_db ||= mob_db_path
    end

    # Items
    def items
      item_hashes = parse_item_db
      item_hashes.collect do |item|
        map_item_from_hash(item)
      end
    end

    # Parse item_db.txt
    def parse_item_db
      data = []
      item_data = read_item_db_file
      item_data.each do |line|
        data << parse_item_line(line)
      end
      data
    end

    private

    # Item db path
    def item_db_path
      [DATABASE_PATH, @version, ITEM_DB_FILENAME].join('/')
    end

    # Mob db path
    def mob_db_path
      [DATABASE_PATH, @version, MOB_DB_FILENAME].join('/')
    end

    # Map item hash to item instance
    def map_item_from_hash(item)
      Item.new(item)
    end

    # Read item file and filter comment
    def read_item_db_file
      read_file(@item_db)
    end

    # Read mob file and filter comment
    def read_mob_db_file
      read_file(@mob_db)
    end

    # Read rAthena file
    def read_file(file)
      raise GdbError, "#{file} not found" unless File.exist?(file)
      item_data = File.read(file).split("\n")
      item_data.reject! do |line_item|
        line_item.start_with?('//')
      end
      item_data
    end

    # Parse item line
    def parse_item_line(item_line)
      data = {}
      splitted_data = item_line.split(',')
      data[:id] = splitted_data[0].to_i
      data[:aegis_name] = splitted_data[1]
      data[:name] = splitted_data[2]
      data[:type] = splitted_data[3] != '' ? splitted_data[3].to_i : nil
      data[:buy] = splitted_data[4] != '' ? splitted_data[4].to_i : nil
      data[:sell] = splitted_data[5] != '' ? splitted_data[5].to_i : nil
      data[:weight] = splitted_data[6] != '' ? splitted_data[6].to_i : nil
      data[:attack] = splitted_data[7] != '' ? splitted_data[7].to_i : nil
      data[:def] = splitted_data[8] != '' ? splitted_data[8].to_i : nil
      data[:range] = splitted_data[9] != '' ? splitted_data[9].to_i : nil
      data[:slot] = splitted_data[10] != '' ? splitted_data[10].to_i : nil
      data[:job] = splitted_data[11] != '' ? splitted_data[11] : nil
      data[:class] = splitted_data[12] != '' ? splitted_data[12].to_i : nil
      data[:gender] = splitted_data[13] != '' ? splitted_data[13].to_i : nil
      data[:loc] = splitted_data[14] != '' ? splitted_data[14].to_i : nil
      data[:wlv] = splitted_data[15] != '' ? splitted_data[15].to_i : nil
      data[:elv] = splitted_data[16] != '' ? splitted_data[16].to_i : nil
      data[:refineable] = splitted_data[17] != '' ? splitted_data[17].to_i : nil
      data[:view] = splitted_data[18] != '' ? splitted_data[18].to_i : nil
      script_data = parse_item_script(splitted_data)
      data[:script] = script_data[0]
      data[:on_equip_script] = script_data[1]
      data[:on_unequip_script] = script_data[2]
      data
    end

    # Parse item script
    def parse_item_script(splitted_data)
      index = 0
      found = false
      splitted_data[19..splitted_data.count].join(',').chars.collect do |u|
        if u == '{' && index != -1
          found = true
          index += 1
          u
        elsif u == '}' && index != -1
          index -= 1
          u
        elsif u != '{' && index.zero?
          u == ',' ? 'parse_item_script' : nil
        else
          u
        end
      end.join.split('parse_item_script')
    end
  end
end
