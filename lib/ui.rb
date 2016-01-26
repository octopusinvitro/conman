require 'console'

class UI

  ADD_ANOTHER = "Add another contact? (y/n): "
  NAME        = "Contact name: "
  ADDRESS     = "Contact address: "
  PHONE       = "Contact phone: "
  EMAIL       = "Contact email: "
  NOTES       = "Contact notes: "

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

  private

  attr_reader :console

end