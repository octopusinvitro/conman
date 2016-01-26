require 'console'
require 'ui'

describe UI do

  it "reads an answer" do
    input   = StringIO.new("y")
    output  = StringIO.new
    ui      = UI.new(Console.new(input, output))

    answer  = ui.ask_for_another

    expect(output.string).to eq(UI::ADD_ANOTHER + "\n")
    expect(answer).to eq("y")
  end

  it "reads a name" do
    input   = StringIO.new("name")
    output  = StringIO.new
    ui      = UI.new(Console.new(input, output))

    answer  = ui.ask_for_name

    expect(output.string).to eq(UI::NAME + "\n")
    expect(answer).to eq("name")
  end

end
