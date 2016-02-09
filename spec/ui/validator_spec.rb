require 'ui/validator'

describe Validator do

  let(:validator) {described_class.new}

  it "detects an invalid menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    expect(validator.valid_option?(menu, "asdf")).to eq(false)
  end

  it "detects a valid menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    expect(validator.valid_option?(menu, "1")).to eq(true)
  end

end