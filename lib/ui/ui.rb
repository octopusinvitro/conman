class UI

  LIST   = "List contacts"
  ADD    = "Add contacts"
  SEARCH = "Search contacts"
  UPDATE = "Update contacts"
  EXIT   = "Exit"

  NAME    = "\nContact name: "
  ADDRESS = "Contact address: "
  PHONE   = "Contact phone: "
  EMAIL   = "Contact email: "
  NOTES   = "Contact notes: "
  FIELDS_TO_QUESTIONS = {
    "name"    => NAME,
    "address" => ADDRESS,
    "phone"   => PHONE,
    "email"   => EMAIL,
    "notes"   => NOTES
  }

  YES          = "y"
  ADD_ANOTHER  = "\nAdd another contact? (y/n): "
  SEARCH_AGAIN = "\nSearch again? (y/n): "
  SEARCH_TERM  = "\nType search term: "

  MENU_OPTION  = "\nChoose a menu option: "
  SEPARATOR    = "--------------------"

  HEADER       = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES"
  HEADER_NAMES = "\nINDEX\tNAME"
  HEADER_WITH_INDEX = "\nINDEX\t" << HEADER[1..-1]

  EXPAND         = "\nDisplay one of these contacts' details? (y/n): "
  EXPAND_CONTACT = "\nChoose a contact to expand: "

  EDIT_CONTACT   = "\nChoose a contact to edit: "
  EDIT_FIELD     = "\nChoose a field to edit: "
  ANOTHER_FIELD  = "\nEdit another field? (y/n): "

  ERROR_NO_CONTACTS = "\nNo contacts were found."
  ERROR_WRONG_INPUT = "ERROR: Wrong input. Please try again: "

  def initialize(console, validator)
    @console   = console
    @validator = validator
  end

  def ask_for_another
    ask_to(ADD_ANOTHER)
  end

  def ask_search_again
    ask_to(SEARCH_AGAIN)
  end

  def ask_to_expand
    ask_to(EXPAND)
  end

  def ask_another_field
    ask_to(ANOTHER_FIELD)
  end

  def ask_for_value_to_edit(field)
    valid_field(FIELDS_TO_QUESTIONS[field], field)
  end

  def ask_for_fields
    contact = {}
    FIELDS_TO_QUESTIONS.each { |field, question| contact[field] = valid_field(question, field) }
    contact
  end

  def ask_for_term
    ask_for(SEARCH_TERM)
  end

  def ask_for_contact_to_expand(size)
    valid_index(EXPAND_CONTACT, size) - 1
  end

  def ask_for_contact_to_edit(size)
    valid_index(EDIT_CONTACT, size) - 1
  end

  def ask_for_field_to_edit
    valid_index(EDIT_FIELD, FIELDS_TO_QUESTIONS.size)
  end

  def ask_menu_option(menu)
    display_menu(menu)
    valid_index(MENU_OPTION, menu.size)
  end

  def display_menu(menu)
    console.writeln
    console.writeln(SEPARATOR)
    menu.each { |item| display_item(item) }
    console.writeln(SEPARATOR)
  end

  def display_item(item)
    line = " " << item[0].to_s << ") " << item[1]
    console.writeln(line)
  end

  def display_all(contacts)
    console.writeln(HEADER)
    contacts.each { |contact| display(contact) }
  end

  def display(contact)
    values = ""
    contact.each { |key, value| values << value << "\t" if key != "id" }
    console.writeln(values)
  end

  def display_names(contacts)
    console.writeln(HEADER_NAMES)
    contacts.each_with_index { |contact, index| display_name(index + 1, contact) }
  end

  def display_name(index, contact)
    line = "" << index.to_s << "\t" << contact["name"]
    console.writeln(line)
  end

  def display_all_with_index(contacts)
    console.writeln(HEADER_WITH_INDEX)
    contacts.each_with_index { |contact, index| display_with_index(index + 1, contact) }
  end

  def display_with_index(index, contact)
    values = " " << index.to_s << "\t"
    contact.each { |key, value| values << value << "\t" if key != "id" }
    console.writeln(values)
  end

  def display_fields_with_index(contact)
    contact.each_with_index { |(key, value), index| console.writeln(format_field(index, key, value)) if key != "id" }
  end

  def format_field(index, key, value)
    field = "" << index.to_s << "\t" << key << ": " << value
  end

  def error_no_contacts
    console.writeln(ERROR_NO_CONTACTS)
  end

  def error_wrong_input
    console.write(ERROR_WRONG_INPUT)
  end

  private

  attr_reader :console, :validator

  def ask_to(question)
    ask_for(question) == YES
  end

  def ask_for(question)
    console.write(question)
    console.read.chomp
  end

  def valid_index(question, size)
    input = ""
    loop do
      input = ask_for(question)
      break if valid?(size, input)
      error_wrong_input
    end
    Integer(input)
  end

  def valid_field(question, field)
    input = ""
    loop do
      input = ask_for(question)
      break if valid_field?(field, input)
      error_wrong_input
    end
    input
  end

  def valid?(size, input)
    validator.valid_index?(size, input)
  end

  def valid_field?(field, input)
    validator.valid_field?(field, input)
  end

end