require 'console'

class UI

  ADD_ANOTHER = "Add another contact? (y/n): "
  NAME        = "Contact name: "
  ADDRESS     = "Contact address: "
  PHONE       = "Contact phone: "
  EMAIL       = "Contact email: "
  NOTES       = "Contact notes: "
  HEADER      = "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"

  def initialize(console)
    @console = console
  end

  def ask_for_another
    console.print(ADD_ANOTHER)
    console.read.chomp
  end

  def ask_for_name
    console.print(NAME)
    console.read.chomp
  end

  def ask_for_address
    console.print(ADDRESS)
    console.read.chomp
  end

  def ask_for_phone
    console.print(PHONE)
    console.read.chomp
  end

  def ask_for_email
    console.print(EMAIL)
    console.read.chomp
  end

  def ask_for_notes
    console.print(NOTES)
    console.read.chomp
  end

  def display(contact)
    values = ""
    contact.each do |key, value|
      values << value + "\t"
    end
    console.print(values)
  end

  def display_all(contacts)
    console.print(HEADER)
    contacts.each do |contact|
      display(contact)
    end
  end

  private

  attr_reader :console

end