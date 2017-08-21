require 'spec_helper'

RSpec.describe Gdbcompiler::Parser do
  it 'Can create instance with given hash data' do
    parser = Gdbcompiler::Parser.new(version: 're')
    expect(parser.version).to eq('re')
  end

  it 'Can create instance with unexpected key' do
    parser = Gdbcompiler::Parser.new(some_random: 're')
    expect(parser.version).to eq('re')
  end

  it 'Can create instance with version specific' do
    parser = Gdbcompiler::Parser.new(version: 'pre-re')
    expect(parser.version).to eq('pre-re')
  end

  it 'Will have default version when version is not given' do
    parser = Gdbcompiler::Parser.new
    expect(parser.version).to eq('re')
  end

  context 'File path' do
    it 'Item db path combination when default' do
      parser = Gdbcompiler::Parser.new
      item_path = parser.send(:item_db_path)
      expect(item_path).to eq('db/re/item_db.txt')
    end

    it 'Item db path combination when re' do
      parser = Gdbcompiler::Parser.new(version: 're')
      item_path = parser.send(:item_db_path)
      expect(item_path).to eq('db/re/item_db.txt')
    end

    it 'Item db path combination when pre-re' do
      parser = Gdbcompiler::Parser.new(version: 'pre-re')
      item_path = parser.send(:item_db_path)
      expect(item_path).to eq('db/pre-re/item_db.txt')
    end

    it 'Item db path could be specify' do
      parser = Gdbcompiler::Parser.new(item_db: 'gas.txt')
      expect(parser.item_db).to eq('gas.txt')
    end
  end

  context 'Parsing item_db' do
    it 'Select item data without comment' do
      parser = Gdbcompiler::Parser.new(item_db: 'spec/db_data/item_db_01.txt')
      item_data = parser.send(:read_item_db_file)
      expect(item_data.count).to eq(1)
    end

    it 'Raise error when item_db is not exist' do
      parser = Gdbcompiler::Parser.new(item_db: 'spec/db_data/wrong_path.txt')
      expect do
        parser.send(:read_item_db_file)
      end.to raise_error(Gdbcompiler::GdbError)
    end

    context 'parse_item_line' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/item_db_02.txt')
        @parser = Gdbcompiler::Parser.new
        @result = @parser.send(:parse_item_line, @mock_item_line)
      end

      it 'id' do
        expect(@result[:id]).to eq(501)
      end

      it 'aegis_name' do
        expect(@result[:aegis_name]).to eq('Red_Potion')
      end

      it 'name' do
        expect(@result[:name]).to eq('Red Potion')
      end

      it 'type' do
        expect(@result[:type]).to eq(0)
      end

      it 'buy' do
        expect(@result[:buy]).to eq(50)
      end

      it 'sell' do
        expect(@result[:sell]).to be_nil
      end

      it 'weight' do
        expect(@result[:weight]).to eq(70)
      end

      it 'attack' do
        expect(@result[:attack]).to be_nil
      end

      it 'def' do
        expect(@result[:def]).to be_nil
      end

      it 'range' do
        expect(@result[:range]).to be_nil
      end

      it 'slot' do
        expect(@result[:slot]).to be_nil
      end

      it 'job' do
        expect(@result[:job]).to eq('0xFFFFFFFF')
      end

      it 'class' do
        expect(@result[:class]).to eq(63)
      end

      it 'gender' do
        expect(@result[:gender]).to eq(2)
      end

      it 'loc' do
        expect(@result[:loc]).to be_nil
      end

      it 'wlv' do
        expect(@result[:wlv]).to be_nil
      end

      it 'elv' do
        expect(@result[:elv]).to be_nil
      end

      it 'refineable' do
        expect(@result[:refineable]).to be_nil
      end

      it 'view' do
        expect(@result[:view]).to be_nil
      end

      it 'script' do
        expect(@result[:script]).to eq('{ itemheal rand(45,65),0; }')
      end

      it 'on_equip_script' do
        expect(@result[:on_equip_script]).to eq('{}')
      end

      it 'on_unequip_script' do
        expect(@result[:on_unequip_script]).to eq('{}')
      end
    end

    context 'map_item_from_hash' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/item_db_02.txt')
        @parser = Gdbcompiler::Parser.new
        @result_hash = @parser.send(:parse_item_line, @mock_item_line)
        @item = @parser.send(:map_item_from_hash, @result_hash)
      end

      it 'id' do
        expect(@item.id).to eq(501)
      end

      it 'aegis_name' do
        expect(@item.aegis_name).to eq('Red_Potion')
      end

      it 'name' do
        expect(@item.name).to eq('Red Potion')
      end

      it 'type' do
        expect(@item.type).to eq(0)
      end

      it 'buy' do
        expect(@item.buy).to eq(50)
      end

      it 'sell' do
        expect(@item.sell).to be_nil
      end

      it 'weight' do
        expect(@item.weight).to eq(70)
      end

      it 'attack' do
        expect(@item.attack).to be_nil
      end

      it 'def' do
        expect(@item.def).to be_nil
      end

      it 'range' do
        expect(@item.range).to be_nil
      end

      it 'slot' do
        expect(@item.slot).to be_nil
      end

      it 'job' do
        expect(@item.job).to eq('0xFFFFFFFF')
      end

      it 'class' do
        expect(@item.class).to eq(63)
      end

      it 'gender' do
        expect(@item.gender).to eq(2)
      end

      it 'loc' do
        expect(@item.loc).to be_nil
      end

      it 'wlv' do
        expect(@item.wlv).to be_nil
      end

      it 'elv' do
        expect(@item.elv).to be_nil
      end

      it 'refineable' do
        expect(@item.refineable).to be_nil
      end

      it 'view' do
        expect(@item.view).to be_nil
      end

      it 'script' do
        expect(@item.script).to eq('{ itemheal rand(45,65),0; }')
      end

      it 'on_equip_script' do
        expect(@item.on_equip_script).to eq('{}')
      end

      it 'on_unequip_script' do
        expect(@item.on_unequip_script).to eq('{}')
      end
    end
  end
end
