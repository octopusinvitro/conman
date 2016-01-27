require 'console'
require 'ui'

describe UI do

  let(:input)  {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui)     {UI.new(Console.new(input, output))}


  it "prints the prompt message for adding another contact" do
    input.string = "\n"
    ui.ask_for_another
    expect_msg(UI::ADD_ANOTHER)
  end

  it "reads a positive answer" do
    input.string = "y"
    expect(ui.ask_for_another).to eq(true)
  end

  it "reads a negative answer" do
    input.string = "n"
    expect(ui.ask_for_another).to eq(false)
  end

  it "prints the prompt message for a name" do
    input.string = "\n"
    ui.ask_for_name
    expect_msg(UI::NAME)
  end

  it "reads a name" do
    input.string = "name"
    expect(ui.ask_for_name).to eq("name")
  end

  it "prints the prompt message for an address" do
    input.string = "\n"
    ui.ask_for_address
    expect_msg(UI::ADDRESS)
  end

  it "reads an address" do
    input.string = "address"
    expect(ui.ask_for_address).to eq("address")
  end

  it "prints the prompt message for a phone" do
    input.string = "\n"
    ui.ask_for_phone
    expect_msg(UI::PHONE)
  end

  it "reads a phone" do
    input.string = "1234"
    expect(ui.ask_for_phone).to eq("1234")
  end

  it "prints the prompt message for an email" do
    input.string = "\n"
    ui.ask_for_email
    expect_msg(UI::EMAIL)
  end

  it "reads an email" do
    input.string = "email@mail.com"
    expect(ui.ask_for_email).to eq("email@mail.com")
  end

  it "prints the prompt message for notes" do
    input.string = "\n"
    ui.ask_for_notes
    expect_msg(UI::NOTES)
  end

  it "reads notes" do
    input.string = "notes"
    expect(ui.ask_for_notes).to eq("notes")
  end

  it "prints a contact" do
     contact = {name: "name", address: "address"}
     ui.display(contact)
     expect(output.string).to eq("name\taddress\t\n")
  end

  it "prints all contacts" do
    contacts = []
    contacts << {name: "name1", address: "address1"}
    contacts << {name: "name2", address: "address2"}
    ui.display_all(contacts)
    expect(output.string.lines.count).to eq(4)
  end

  def expect_msg(message)
    expect(output.string.chomp).to eq(message)
  end
end
