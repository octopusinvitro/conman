class UI

  ADD_ANOTHER  = "\nAdd another contact? (y/n): "
  NAME         = "\nContact name: "
  ADDRESS      = "Contact address: "
  PHONE        = "Contact phone: "
  EMAIL        = "Contact email: "
  NOTES        = "Contact notes: "

  SEARCH_AGAIN = "\nSearch again? (y/n): "
  SEARCH       = "\nType search term: "

  MENU         = "\nChoose a menu option: "

  HEADER       = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"
  HEADER_NAMES = "\nINDEX\tNAME\n"

  def initialize(console)
    @console = console
  end

  def ask_for_another
    add_another == "y" ? true : false
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
    search_another == "y" ? true : false
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
    menu.each do |item|
      display_item(item)
    end
  end

  def display_item(item)
    line = "" << item[0].to_s << ") " << item[1]
    console.writeln(line)
  end

  def display(contact)
    values = ""
    contact.each do |key, value|
      values << value << "\t"
    end
    console.writeln(values)
  end

  def display_names(contacts)
    console.write(HEADER_NAMES)
    index = 0
    contacts.each do |contact|
      index += 1
      display_name(index, contact)
    end
  end

  def display_name(index, contact)
    line = "" << index.to_s << "\t" << contact[:name]
    console.writeln(line)
  end

  def display_all(contacts)
    console.write(HEADER)
    contacts.each do |contact|
      display(contact)
    end
  end

  private

  attr_reader :console

  def add_another
    ask_for_field(ADD_ANOTHER)
  end

  def search_another
    ask_for_field(SEARCH_AGAIN)
  end

  def ask_for_field(question)
    console.write(question)
    console.read.chomp
  end
end