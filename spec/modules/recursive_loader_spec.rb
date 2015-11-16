require 'spec_helper'

describe RecursiveLoader do

  before :each do
    $arr = []
    @dir = Pathname.new(File.expand_path('./spec/support/load'))
  end

  it 'load with default order' do
    loader.load_modules(@dir)
    expect($arr).to eq([:a, :b, :c, :d, :e, :a, :b])
  end

  it 'load with default order' do
    loader.load_modules(@dir, %w{ b })
    expect($arr).to eq([:b, :a, :c, :d, :e, :b, :a])
  end

  def loader(method = :load)
    RecursiveLoader.new(method)
  end

end
