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
    console.print(contact[:name] + "\t" +
      contact[:address] + "\t" +
      contact[:phone]   + "\t" +
      contact[:email]   + "\t" +
      contact[:notes]   + "\n")
  end

  private

  attr_reader :console

end