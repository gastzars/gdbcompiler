require 'spec_helper'

RSpec.describe Gdbcompiler::Effect do
  it 'rand' do
    effect = Gdbcompiler::Effect.new
    resp = effect.send(:rand, 1, 10)
    expect(resp).to eq('1 ~ 10')
  end

  context 'map_raw_to_values' do
    context 'single effect' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_01.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('itemheal rand(45,65),0')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('itemheal')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is rand(45,65)' do
        expect(@effect.variables[0]).to eq('rand(45,65)')
      end

      it 'second variables is 0' do
        expect(@effect.variables[1]).to eq('0')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ฟื้นฟู : HP ^00008845 ~ 65^000000')
      end
    end

    context 'itemheal only hp' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_01.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('itemheal rand(45,65),0')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('itemheal')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is rand(45,65)' do
        expect(@effect.variables[0]).to eq('rand(45,65)')
      end

      it 'second variables is 0' do
        expect(@effect.variables[1]).to eq('0')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ฟื้นฟู : HP ^00008845 ~ 65^000000')
      end
    end

    context 'itemheal only sp' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_02.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('itemheal 0,10')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('itemheal')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is 0' do
        expect(@effect.variables[0]).to eq('0')
      end

      it 'second variables is 10' do
        expect(@effect.variables[1]).to eq('10')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ฟื้นฟู : SP ^00008810^000000')
      end
    end

    context 'itemheal hp and sp' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_03.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('itemheal rand(45,65),rand(10,15)')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('itemheal')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is 0' do
        expect(@effect.variables[0]).to eq('rand(45,65)')
      end

      it 'second variables is 10' do
        expect(@effect.variables[1]).to eq('rand(10,15)')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq("ฟื้นฟู : HP ^00008845 ~ 65^000000\nฟื้นฟู : SP ^00008810 ~ 15^000000")
      end
    end

    context 'sc_end' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_04.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('sc_end SC_POISON')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('sc_end')
      end

      it 'has 1 variable' do
        expect(@effect.variables.count).to eq(1)
      end

      it 'first variables is SC_POISON' do
        expect(@effect.variables[0]).to eq('SC_POISON')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('รักษา : ^006600พิษ^000000')
      end
    end

    context 'sc_start no value and flag' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_05.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('sc_start SC_FREEZE,10000,0,2500,0')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('sc_start')
      end

      it 'has 5 variables' do
        expect(@effect.variables.count).to eq(5)
      end

      it 'first variables is SC_FREEZE' do
        expect(@effect.variables[0]).to eq('SC_FREEZE')
      end

      it 'second variables is 10000' do
        expect(@effect.variables[1]).to eq('10000')
      end

      it 'third variables is 0' do
        expect(@effect.variables[2]).to eq('0')
      end

      it 'fourth variables is 2500' do
        expect(@effect.variables[3]).to eq('2500')
      end

      it 'fifth variables is 0' do
        expect(@effect.variables[4]).to eq('0')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ผล : มีโอกาส ^00660025^000000 % ที่จะ ^006600แช่แข็ง^000000 ใส่ตัวเอง เป็นเวลา ^00660010 วินาที^000000')
      end
    end

    context 'itemskill' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_06.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('itemskill "AL_TELEPORT",1')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('itemskill')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is "AL_TELEPORT"' do
        expect(@effect.variables[0]).to eq('"AL_TELEPORT"')
      end

      it 'second variables is 1' do
        expect(@effect.variables[1]).to eq('1')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ผล : ใช้สกิล ^006600Teleport^000000 Lv. 1')
      end
    end

    context 'getrandgroupitem' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_07.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('getrandgroupitem(IG_BlueBox,1)')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('getrandgroupitem')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is IG_BlueBox' do
        expect(@effect.variables[0]).to eq('IG_BlueBox')
      end

      it 'second variables is 1' do
        expect(@effect.variables[1]).to eq('1')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ผล : สุ่ม Item 1 ชิ้น จาก ^006600Old Blue Box^000000')
      end
    end

    context 'monster' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_08.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('monster "this",-1,-1,"--ja--",-1-MOBG_Branch_Of_Dead_Tree,1,""')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('monster')
      end

      it 'has 7 variables' do
        expect(@effect.variables.count).to eq(7)
      end

      it 'first variables is "this"' do
        expect(@effect.variables[0]).to eq('"this"')
      end

      it 'second variables is -1' do
        expect(@effect.variables[1]).to eq('-1')
      end

      it 'third variables is -1' do
        expect(@effect.variables[2]).to eq('-1')
      end

      it 'fourth variables is "--ja--"' do
        expect(@effect.variables[3]).to eq('"--ja--"')
      end

      it 'fifth variables is -1-MOBG_Branch_Of_Dead_Tree' do
        expect(@effect.variables[4]).to eq('-1-MOBG_Branch_Of_Dead_Tree')
      end

      it 'sixth variables is 1' do
        expect(@effect.variables[5]).to eq('1')
      end

      it 'seventh variables is ""' do
        expect(@effect.variables[6]).to eq('""')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('ผล : สุ่มเสก Monster ระดับ ธรรมดา')
      end
    end

    context 'percentheal' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_09.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('percentheal 100,100')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('percentheal')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(2)
      end

      it 'first variables is 100' do
        expect(@effect.variables[0]).to eq('100')
      end

      it 'second variables is 100' do
        expect(@effect.variables[1]).to eq('100')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq("ฟื้นฟู : HP ^000088100^000000 %\nฟื้นฟู : SP ^000088100^000000 %")
      end
    end

    context 'produce' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/effect_db_10.txt')
        @effect = Gdbcompiler::Effect.new(raw: @mock_item_line)
      end

      it 'has the correct raw' do
        expect(@effect.raw).to eq('produce 1')
      end

      it 'has the correct type' do
        expect(@effect.type).to eq('produce')
      end

      it 'has 2 variables' do
        expect(@effect.variables.count).to eq(1)
      end

      it 'first variables is 1' do
        expect(@effect.variables[0]).to eq('1')
      end

      it 'has correct translate' do
        expect(@effect.translate).to eq('สร้าง : ใช้สำหรับสร้าง อาวุธเลเวล 1')
      end
    end

    it 'sc_start with percent value'
    it 'sc_start with level value'
    it 'sc_start with default value'
    it 'sc_start with flag'
  end
end
