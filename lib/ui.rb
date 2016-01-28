require 'console'

class UI

  ADD_ANOTHER = "Add another contact? (y/n): "
  NAME        = "Contact name: "
  ADDRESS     = "Contact address: "
  PHONE       = "Contact phone: "
  EMAIL       = "Contact email: "
  NOTES       = "Contact notes: "
  SEARCH      = "Type search term: "
  HEADER      = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"

  def initialize(console)
    @console = console
  end

  def ask_for_another
    add_another == "y" ? true : false
  end

  def ask_for_name
    console.write(NAME)
    console.read.chomp
  end

  def ask_for_address
    console.write(ADDRESS)
    console.read.chomp
  end

  def ask_for_phone
    console.write(PHONE)
    console.read.chomp
  end

  def ask_for_email
    console.write(EMAIL)
    console.read.chomp
  end

  def ask_for_notes
    console.write(NOTES)
    console.read.chomp
  end

  def ask_to_search
    console.write(SEARCH)
    console.read.chomp
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
    console.write(ADD_ANOTHER)
    console.read.chomp
  end

end