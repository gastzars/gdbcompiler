require 'spec_helper'

RSpec.describe Gdbcompiler::Script do
  context 'map_raw_to_values' do
    context 'single effect' do
      before(:all) do
        @mock_item_line = File.read('spec/db_data/script_db_01.txt')
        @script = Gdbcompiler::Script.new(raw: @mock_item_line)
      end

      it 'raw' do
        expect(@script.raw).to eq('{ itemheal rand(45,65),0; }')
      end

      it 'has 1 value' do
        expect(@script.values.count).to eq(1)
      end
    end
  end
end
