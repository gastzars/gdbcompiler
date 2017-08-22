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
        expect(@effect.translate).to eq('ฟื้นฟู HP ^00008845 ~ 65^000000')
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
        expect(@effect.translate).to eq('ฟื้นฟู HP ^00008845 ~ 65^000000')
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
        expect(@effect.translate).to eq('ฟื้นฟู SP ^00008810^000000')
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
        expect(@effect.translate).to eq("ฟื้นฟู HP ^00008845 ~ 65^000000\nฟื้นฟู SP ^00008810 ~ 15^000000")
      end
    end
  end
end
