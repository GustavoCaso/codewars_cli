require File.expand_path('../../../lib/codewars_cli/concerns/attributes_methods', __FILE__)
require 'spec_helper'

class TestClass
  include CodewarsCli::Concerns::AttributesMethods
  attr_reader :foo, :bar, :baz, :hello
  def initialize(foo,bar,baz,hello)
    @foo = foo
    @bar = bar
    @baz = baz
    @hello = hello
  end
end

describe TestClass do
  it 'return attributes hash with all key values' do
    o = described_class.new(1,2,3,45)
    expect(o.attributes).to eq({foo: 1, bar: 2, baz: 3, hello: 45})
  end
end

