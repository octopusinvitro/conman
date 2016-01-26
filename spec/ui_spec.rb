require 'console'
require 'ui'

describe UI do

  let(:input)  {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui)     {UI.new(Console.new(input, output))}

  it "reads an answer" do
    input.string = "y"
    answer       = ui.ask_for_another
    expect(output.string.chomp).to eq(UI::ADD_ANOTHER)
    expect(answer).to eq("y")
  end

  it "reads a name" do
    input.string = "name"
    name         = ui.ask_for_name
    expect(output.string.chomp).to eq(UI::NAME)
    expect(name).to eq("name")
  end

  it "reads an address" do
    input.string = "address"
    address      = ui.ask_for_address
    expect(output.string.chomp).to eq(UI::ADDRESS)
    expect(address).to eq("address")
  end

  it "reads a phone" do
    input.string = "1234"
    phone        = ui.ask_for_phone
    expect(output.string.chomp).to eq(UI::PHONE)
    expect(phone).to eq("1234")
  end

  it "reads an email" do
    input.string = "email@mail.com"
    email        = ui.ask_for_email
    expect(output.string.chomp).to eq(UI::EMAIL)
    expect(email).to eq("email@mail.com")
  end

  it "reads notes" do
    input.string = "notes"
    notes        = ui.ask_for_notes
    expect(output.string.chomp).to eq(UI::NOTES)
    expect(notes).to eq("notes")
  end
  end
end
