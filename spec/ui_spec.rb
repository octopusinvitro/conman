require 'console'
require 'ui'

describe UI do

  let(:input)  {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui)     {UI.new(Console.new(input, output))}


  it "prints the prompt message for adding another contact" do
    input.string = "\n"
    ui.ask_for_another
    expect_to_print(UI::ADD_ANOTHER)
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
    expect_to_print(UI::NAME)
  end

  it "reads a name" do
    input.string = "name"
    expect(ui.ask_for_name).to eq("name")
  end

  it "prints the prompt message for an address" do
    input.string = "\n"
    ui.ask_for_address
    expect_to_print(UI::ADDRESS)
  end

  it "reads an address" do
    input.string = "address"
    expect(ui.ask_for_address).to eq("address")
  end

  it "prints the prompt message for a phone" do
    input.string = "\n"
    ui.ask_for_phone
    expect_to_print(UI::PHONE)
  end

  it "reads a phone" do
    input.string = "1234"
    expect(ui.ask_for_phone).to eq("1234")
  end

  it "prints the prompt message for an email" do
    input.string = "\n"
    ui.ask_for_email
    expect_to_print(UI::EMAIL)
  end

  it "reads an email" do
    input.string = "email@mail.com"
    expect(ui.ask_for_email).to eq("email@mail.com")
  end

  it "prints the prompt message for notes" do
    input.string = "\n"
    ui.ask_for_notes
    expect_to_print(UI::NOTES)
  end

  it "reads notes" do
    input.string = "notes"
    expect(ui.ask_for_notes).to eq("notes")
  end

  it "prints the prompt message for repeating search" do
    input.string = "\n"
    ui.ask_search_again
    expect_to_print(UI::SEARCH_AGAIN)
  end

  it "reads a positive answer to search again" do
    input.string = "y"
    expect(ui.ask_search_again).to eq(true)
  end

  it "reads a negative answer to search again" do
    input.string = "n"
    expect(ui.ask_search_again).to eq(false)
  end

  it "prints the prompt message for a search" do
    input.string = "\n"
    ui.ask_for_term
    expect_to_print(UI::SEARCH)
  end

  it "reads search term" do
    input.string = "search term"
    expect(ui.ask_for_term).to eq("search term")
  end

  it "prints the menu with format" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "1"
    ui.ask_menu_option(menu)
    expect(output.string).to include("\n--------------------\n 1) Option 1\n 2) Option 2\n--------------------\n")
  end

  it "prints the prompt message for choosing a menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "1"
    ui.ask_menu_option(menu)
    expect(output.string).to include(UI::MENU)
  end

  it "reads a menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "1"
    expect(ui.ask_menu_option(menu)).to eq(1)
  end

  it "prints a contact" do
     contact = {name: "name", address: "address"}
     ui.display(contact)
     expect(output.string).to eq("name\taddress\t\n")
  end

  it "prints all contacts" do
    contacts = [
      {name: "name1", address: "address1"},
      {name: "name2", address: "address2"}
    ]
    ui.display_all(contacts)
    expect(output.string.lines.count).to eq(4)
  end

  it "prints a contact but only the name" do
     contact = {name: "name", address: "address"}
     ui.display_name(1, contact)
     expect(output.string).to eq("1\tname\n")
  end

  it "prints all contacts but only the names" do
    contacts = [
      {name: "name1", address: "address1"},
      {name: "name2", address: "address2"}
    ]
    ui.display_names(contacts)
    expect(output.string.lines.count).to eq(4)
  end

  it "prints the prompt message for asking for a contact" do
    input.string = "1"
    ui.ask_for_contact
    expect_to_print(UI::CONTACT)
  end

  it "reads a contact's index" do
    input.string = "1"
    expect(ui.ask_for_contact).to eq(1)
  end

  it "prints the prompt message for expanding a contact's details" do
    input.string = "\n"
    ui.ask_to_expand
    expect_to_print(UI::EXPAND)
  end

  it "reads a positive answer to expand contact details" do
    input.string = "y"
    expect(ui.ask_to_expand).to eq(true)
  end

  it "reads a negative answer to expand contact details" do
    input.string = "n"
    expect(ui.ask_to_expand).to eq(false)
  end

  it "prints an error message for no contacts" do
    ui.error_no_contacts
    expect_to_print(UI::ERROR_NO_CONTACTS)
  end

  def expect_to_print(message)
    expect(output.string.chomp).to eq(message)
  end
end
