require 'console'
require 'ui'

describe UI do
  let (:input)   {StringIO.new("y")}
  let (:output)  {StringIO.new}
  let (:console) {Console.new(input, output)}
  let (:ui)      {UI.new(console)}

  it "prints ADD_ANOTHER question and reads output" do
  	answer = ui.ask_for_another
    expect(output.string).to eq(UI::ADD_ANOTHER + "\n")
    expect(answer).to eq("y")
  end

end
