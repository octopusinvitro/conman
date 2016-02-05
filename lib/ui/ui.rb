class UI

  ADD_ANOTHER  = "\nAdd another contact? (y/n): "
  NAME         = "\nContact name: "
  ADDRESS      = "Contact address: "
  PHONE        = "Contact phone: "
  EMAIL        = "Contact email: "
  NOTES        = "Contact notes: "

  SEARCH_AGAIN = "\nSearch again? (y/n): "
  SEARCH       = "\nType search term: "

  MENU         = "Choose a menu option: "
  SEPARATOR    = "--------------------"

  HEADER       = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES"
  HEADER_NAMES = "\nINDEX\tNAME"

  EXPAND         = "\nDisplay one of these contacts' details? (y/n): "
  EXPAND_CONTACT = "\nChoose a contact to expand: "
  EDIT_CONTACT   = "\nChoose a contact to edit: "

  ERROR_NO_CONTACTS = "\nNo contacts were found."

  def initialize(console)
    @console = console
  end

  def ask_for_another
    ask_to(ADD_ANOTHER)
  end

  def ask_for_name
    ask_for_field(NAME)
  end

  def ask_for_address
    ask_for_field(ADDRESS)
  end

  def ask_for_phone
    ask_for_field(PHONE)
  end

  def ask_for_email
    ask_for_field(EMAIL)
  end

  def ask_for_notes
    ask_for_field(NOTES)
  end

  def ask_search_again
    ask_to(SEARCH_AGAIN)
  end

  def ask_for_term
    ask_for_field(SEARCH)
  end

  def ask_menu_option(menu)
    display_menu(menu)
    Integer(ask_for_field(MENU))
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
    contact.each { |key, value| values << value << "\t" }
    console.writeln(values)
  end

  def display_names(contacts)
    console.writeln(HEADER_NAMES)
    index = 0
    contacts.each do |contact|
      index += 1
      display_name(index, contact)
    end
  end

  def display_name(index, contact)
    line = "" << index.to_s << "\t" << contact["name"]
    console.writeln(line)
  end

  def ask_for_contact_to_expand
    Integer(ask_for_field(EXPAND_CONTACT))
  end

  def ask_for_contact_to_edit
    Integer(ask_for_field(EDIT_CONTACT))
  end

  def ask_to_expand
    ask_to(EXPAND)
  end

  def error_no_contacts
    console.writeln(ERROR_NO_CONTACTS)
  end

  def ask_for_fields
    contact            = {}
    contact["name"]    = ask_for_name
    contact["address"] = ask_for_address
    contact["phone"]   = ask_for_phone
    contact["email"]   = ask_for_email
    contact["notes"]   = ask_for_notes
    contact
  end

  def display_all_with_index(contacts)
    console.writeln(HEADER)
    index = 0
    contacts.each do |contact|
      index += 1
      display_with_index(index, contact)
    end
  end

  def display_with_index(index, contact)
    values = " " << index.to_s << "\t"
    contact.each { |key, value| values << value << "\t" }
    console.writeln(values)
  end

  private

  attr_reader :console

  def ask_for_field(question)
    console.write(question)
    console.read.chomp
  end

  def ask_to(question)
    ask_for_field(question) == "y" ? true : false
  end

end