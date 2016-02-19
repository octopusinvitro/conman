require 'ui/console'
require 'ui/ui'

describe UI do

  let(:input)  {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui)     {described_class.new(Console.new(input, output), Validator.new)}

  it "prints the prompt message for adding another contact" do
    input.string = "\n"
    ui.ask_for_another
    expect_to_print(UI::ADD_ANOTHER)
  end

  it "reads a positive answer to adding another contact" do
    input.string = UI::YES
    expect(ui.ask_for_another).to eq(true)
  end

  it "reads a negative answer to adding another contact" do
    input.string = "\n"
    expect(ui.ask_for_another).to eq(false)
  end

  it "prints the prompt message for repeating search" do
    input.string = "\n"
    ui.ask_search_again
    expect_to_print(UI::SEARCH_AGAIN)
  end

  it "reads a positive answer to search again" do
    input.string = UI::YES
    expect(ui.ask_search_again).to eq(true)
  end

  it "reads a negative answer to search again" do
    input.string = "\n"
    expect(ui.ask_search_again).to eq(false)
  end

  it "prints the prompt message for expanding a contact's details" do
    input.string = "\n"
    ui.ask_to_expand
    expect_to_print(UI::EXPAND)
  end

  it "reads a positive answer to expand contact details" do
    input.string = UI::YES
    expect(ui.ask_to_expand).to eq(true)
  end

  it "reads a negative answer to expand contact details" do
    input.string = "\n"
    expect(ui.ask_to_expand).to eq(false)
  end

  it "prints the prompt message for expanding a contact's details" do
    input.string = "\n"
    ui.ask_another_field
    expect_to_print(UI::ANOTHER_FIELD)
  end

  it "reads a positive answer to ask another field" do
    input.string = UI::YES
    expect(ui.ask_another_field).to eq(true)
  end

  it "reads a negative answer to ask another field" do
    input.string = "\n"
    expect(ui.ask_another_field).to eq(false)
  end

  it "prints the prompt message for a name" do
    input.string = "\n"
    ui.ask_for_value_to_edit("name")
    expect_to_print(UI::NAME)
  end

  it "reads a name" do
    input.string = "a name"
    expect(ui.ask_for_value_to_edit("name")).to eq("a name")
  end

  it "prints the prompt message for an address" do
    input.string = "\n"
    ui.ask_for_value_to_edit("address")
    expect_to_print(UI::ADDRESS)
  end

  it "reads an address" do
    input.string = "an address"
    expect(ui.ask_for_value_to_edit("address")).to eq("an address")
  end

  it "prints the prompt message for a phone" do
    input.string = "01234567890"
    ui.ask_for_value_to_edit("phone")
    expect_to_print(UI::PHONE)
  end

  it "reads a phone" do
    input.string = "01234567890"
    expect(ui.ask_for_value_to_edit("phone")).to eq("01234567890")
  end

  it "prints an error message if the phone is not valid" do
    input.string = "asdf\n01234567890"
    ui.ask_for_value_to_edit("phone")
    expect(output.string).to include(UI::ERROR_WRONG_PHONE)
  end

  it "keeps asking until valid phone number" do
    input.string = "asdf\n1234\n01234567890"
    expect(ui.ask_for_value_to_edit("phone")).to eq("01234567890")
    expect_field_error_count_to_be(2, "phone")
  end

  it "prints the prompt message for an email" do
    input.string = "email@mail.com"
    ui.ask_for_value_to_edit("email")
    expect_to_print(UI::EMAIL)
  end

  it "reads an email" do
    input.string = "email@mail.com"
    expect(ui.ask_for_value_to_edit("email")).to eq("email@mail.com")
  end

  it "prints an error message if the email is not valid" do
    input.string = "asdf\nemail@mail.com"
    ui.ask_for_value_to_edit("email")
    expect(output.string).to include(UI::ERROR_WRONG_EMAIL)
  end

  it "keeps asking until valid email" do
    input.string = "asdf\n1234\nemail@mail.com"
    expect(ui.ask_for_value_to_edit("email")).to eq("email@mail.com")
    expect_field_error_count_to_be(2, "email")
  end

  it "prints the prompt message for notes" do
    input.string = "\n"
    ui.ask_for_value_to_edit("notes")
    expect_to_print(UI::NOTES)
  end

  it "reads notes" do
    input.string = "notes"
    expect(ui.ask_for_value_to_edit("notes")).to eq("notes")
  end

  it "asks for all fields" do
    input.string = "name\naddress\n01234567890\nemail@mail.com\nnotes"
    contact      = {"name" => "name", "address" => "address", "phone" => "01234567890", "email" => "email@mail.com", "notes" => "notes", }
    expect(ui.ask_for_fields).to eq(contact)
  end

  it "prints the prompt message for a search" do
    input.string = "\n"
    ui.ask_for_term
    expect_to_print(UI::SEARCH_TERM)
  end

  it "reads search term" do
    input.string = "search term"
    expect(ui.ask_for_term).to eq("search term")
  end

  it "prints the prompt message for asking for a contact to expand" do
    input.string = "1"
    ui.ask_for_contact_to_expand(1)
    expect_to_print(UI::EXPAND_CONTACT)
  end

  it "reads an contact's index to expand" do
    input.string = "1"
    expect(ui.ask_for_contact_to_expand(1)).to eq(0)
  end

  it "prints an error message if wrong contact index to expand" do
    input.string = "asdf\n1"
    ui.ask_for_contact_to_expand(1)
    expect(output.string).to include(UI::ERROR_WRONG_INPUT)
  end

  it "keeps asking until valid contact index to expand" do
    input.string = "asdf\n-1\n0\n1"
    expect(ui.ask_for_contact_to_expand(1)).to eq(0)
    expect_error_message_count_to_be(3)
  end

  it "prints the prompt message for asking for a contact to edit" do
    input.string = "1"
    ui.ask_for_contact_to_edit(1)
    expect_to_print(UI::EDIT_CONTACT)
  end

  it "reads a contact's index to edit" do
    input.string = "1"
    expect(ui.ask_for_contact_to_edit(1)).to eq(0)
  end

  it "prints an error message if wrong contact index" do
    input.string = "asdf\n1"
    ui.ask_for_contact_to_edit(1)
    expect(output.string).to include(UI::ERROR_WRONG_INPUT)
  end

  it "keeps asking until valid contact index" do
    input.string = "asdf\n-1\n0\n1"
    expect(ui.ask_for_contact_to_edit(1)).to eq(0)
    expect_error_message_count_to_be(3)
  end

  it "prints the prompt message for asking for a field to edit" do
    input.string = "1"
    ui.ask_for_field_to_edit
    expect_to_print(UI::EDIT_FIELD)
  end

  it "reads a contact's index to edit" do
    input.string = "1"
    expect(ui.ask_for_field_to_edit).to eq(1)
  end

  it "prints an error message if wrong field index" do
    input.string = "asdf\n1"
    ui.ask_for_field_to_edit
    expect(output.string).to include(UI::ERROR_WRONG_INPUT)
  end

  it "keeps asking until valid field index" do
    input.string = "asdf\n-1\n0\n1"
    expect(ui.ask_for_field_to_edit).to eq(1)
    expect_error_message_count_to_be(3)
  end

  it "prints the prompt message for choosing a menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "1"
    ui.ask_menu_option(menu)
    expect(output.string).to include(UI::MENU_OPTION)
  end

  it "reads a menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "1"
    expect(ui.ask_menu_option(menu)).to eq(1)
  end

  it "prints an error message if wrong input" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "asdf\n1"
    ui.ask_menu_option(menu)
    expect(output.string).to include(UI::ERROR_WRONG_INPUT)
  end

  it "keeps asking until right menu option" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    input.string = "asdf\n-1\n0\n1"
    expect(ui.ask_menu_option(menu)).to eq(1)
    expect_error_message_count_to_be(3)
  end

  it "prints the menu with format" do
    menu = [[1, "Option 1"], [2, "Option 2"]]
    ui.display_menu(menu)
    expect(output.string).to include("\n--------------------\n 1) Option 1\n 2) Option 2\n--------------------\n")
  end

  it "prints a contact" do
     contact = {"id" => 1, "name" => "name", "address" => "address"}
     ui.display(contact)
     expect(output.string).to eq("name\taddress\t\n")
  end

  it "prints all contacts" do
    contacts = [
      {"id" => 1, "name" => "name1", "address" => "address1"},
      {"id" => 2, "name" => "name2", "address" => "address2"}
    ]
    ui.display_all(contacts)
    expect(output.string.lines.count).to eq(4)
    expect(output.string).to include(UI::HEADER)
  end

  it "prints a contact but only the name" do
     contact = {"id" => 1, "name" => "name", "address" => "address"}
     ui.display_name(1, contact)
     expect(output.string).to eq("1\tname\n")
  end

  it "prints all contacts but only the names" do
    contacts = [
      {"id" => 1, "name" => "name1", "address" => "address1"},
      {"id" => 2, "name" => "name2", "address" => "address2"}
    ]
    ui.display_names(contacts)
    expect(output.string.lines.count).to eq(4)
    expect(output.string).to include(UI::HEADER_NAMES)
  end

  it "prints a full contact with an index" do
     contact = {"id" => 1, "name" => "name", "address" => "address"}
     ui.display_with_index(1, contact)
     expect(output.string).to eq(" 1\tname\taddress\t\n")
  end

  it "displays all contacts with an index" do
    contacts = [
      {"name" => "name1", "address" => "address1"},
      {"name" => "name2", "address" => "address2"}
    ]
    ui.display_all_with_index(contacts)
    expect(output.string.lines.count).to eq(4)
    expect(output.string).to include(UI::HEADER_WITH_INDEX)
  end

  it "formats a field with index" do
    expect(ui.format_field(1, "name", "a name")).to eq("1\t" << "name: "<< "a name")
  end

  it "prints all fields with index" do
    contact = {"id" => 1, "name" => "name", "address" => "address", "phone" => "1234", "email" => "email@mail.com", "notes" => "notes", }
    ui.display_fields_with_index(contact)
    expect(output.string.lines.count).to eq(5)
  end

  it "prints an error message for no contacts" do
    ui.error_no_contacts
    expect_to_print(UI::ERROR_NO_CONTACTS)
  end

  it "prints an error message for wrong input" do
    ui.error_wrong_input
    expect_to_print(UI::ERROR_WRONG_INPUT)
  end

  it "clears the screen" do
    ui.clear
    expect_to_print(UI::CLEAR)
  end

  it "prints a goodbye message" do
    ui.bye
    expect(output.string).to include(UI::BYE)
    expect(output.string.lines.count).to eq(4)
  end

  it "returns the fields of a contact" do
    fields = ["name", "address", "phone", "email", "notes"]
    expect(ui.contact_fields).to eq(fields)
  end

  def expect_to_print(message)
    expect(output.string.chomp).to eq(message)
  end

  def expect_error_message_count_to_be(count)
    expect(output.string.scan(UI::ERROR_WRONG_INPUT).size).to eq(count)
  end

  def expect_field_error_count_to_be(count, field)
    expect(output.string.scan(ui.error_message_for(field)).size).to eq(count)
  end

end