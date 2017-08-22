require 'spec_helper'

RSpec.describe Gdbcompiler::Effect do
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
    end
  end
end