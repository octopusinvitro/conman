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

  it "doesn't have any rules for names" do
    expect(validator.valid_field?("name", "as@£$%123df")).to eq(true)
  end

  it "doesn't have any rules for addresses" do
    expect(validator.valid_field?("name", "as%^&dlkjdsf")).to eq(true)
  end

  it "detects a valid phone" do
    expect(validator.valid_field?("phone", "01234567890")).to eq(true)
  end

  it "detects an invalid phone if it is not a number" do
    expect(validator.valid_field?("phone", "asdf")).to eq(false)
  end

  it "detects an invalid phone if it doesn't have enough digits" do
    expect(validator.valid_field?("phone", "1234")).to eq(false)
  end

  it "detects a valid email" do
    expect(validator.valid_field?("email", "sdf@sdf")).to eq(true)
  end

  it "detects an invalid email if it doesn't have the at symbol" do
    expect(validator.valid_field?("email", "sdfsdf")).to eq(false)
  end

  it "doesn't have any rules for notes" do
    expect(validator.valid_field?("notes", "lkj23487")).to eq(true)
  end

end