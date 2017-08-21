require 'spec_helper'

RSpec.describe Gdbcompiler::Item do
  it 'Can be create with hash' do
    item = Gdbcompiler::Item.new(id: 1)
    expect(item.id).to eq(1)
  end

  it 'No default value' do
    item = Gdbcompiler::Item.new
    expect(item.id).to be_nil
  end
end
