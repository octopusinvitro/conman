class UI

  ADD_ANOTHER  = "Add another contact? (y/n): "
  NAME         = "Contact name: "
  ADDRESS      = "Contact address: "
  PHONE        = "Contact phone: "
  EMAIL        = "Contact email: "
  NOTES        = "Contact notes: "

  SEARCH_AGAIN = "Search again? (y/n): "
  SEARCH       = "Type search term: "

  HEADER       = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"

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
    Integer(console.read.chomp)
  end

  def display_menu(menu)
    menu.each do |item|
      console.write(item[0].to_s + ") " + item[1] + "\n")
    end
  end

  def display(contact)
    values = ""
    contact.each do |key, value|
      values << value + "\t"
    end
    console.write(values)
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