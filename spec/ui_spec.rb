require 'console'
require 'ui'

describe UI do

  it "reads an answer" do
    input   = StringIO.new("y")
    output  = StringIO.new
    ui      = UI.new(Console.new(input, output))

    answer  = ui.ask_for_another

    expect(output.string.chomp).to eq(UI::ADD_ANOTHER)
    expect(answer).to eq("y")
  end

  it "reads a name" do
    input   = StringIO.new("name")
    output  = StringIO.new
    ui      = UI.new(Console.new(input, output))

    name  = ui.ask_for_name

    expect(output.string.chomp).to eq(UI::NAME)
    expect(name).to eq("name")
  end

  it "reads an address" do
    input   = StringIO.new("address")
    output  = StringIO.new
    ui      = UI.new(Console.new(input, output))

    address = ui.ask_for_address

    expect(output.string.chomp).to eq(UI::ADDRESS)
    expect(address).to eq("address")
  end

end
