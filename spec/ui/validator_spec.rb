require 'ui/validator'

describe Validator do

  let(:validator) {described_class.new}

  it "detects an invalid index" do
    list = ["first", "second", "third"]
    expect(validator.valid_index?(list.size, "asdf")).to eq(false)
    expect(validator.valid_index?(list.size, "-1")).to eq(false)
    expect(validator.valid_index?(list.size, "0")).to eq(false)
  end

  it "detects a valid index" do
    list = ["first", "second", "third"]
    expect(validator.valid_index?(list.size, "1")).to eq(true)
    expect(validator.valid_index?(list.size, "2")).to eq(true)
    expect(validator.valid_index?(list.size, "3")).to eq(true)
  end

end