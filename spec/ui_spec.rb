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

end
