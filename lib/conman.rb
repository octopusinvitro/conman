require 'console'

class Conman

  def initialize(console)
  	@console = console
  	@contact_list = []
  end


  def add_contact
  	name    = ask_for_name
  	address = ask_for_address
  	phone   = ask_for_phone
    email   = ask_for_email
    notes   = ask_for_notes

  	contact = {}
  	contact[:name]    = name
  	contact[:address] = address
  	contact[:phone]   = phone
  	contact[:email]   = email
  	contact[:notes]   = notes
  	contact_list << contact
  end

  def add_name
  	console.print("Contact name: ")
  	console.read.chomp
  end

  def ask_for_address
	  console.print("Contact address: ")
  	console.read.chomp
  end

  def ask_for_phone
  	console.print("Contact phone: ")
    console.read.chomp
  end

  def ask_for_email
  	console.print("Contact email: ")
    console.read.chomp
  end

  def ask_for_notes
  	console.print("Contact notes")
  	console.read.chomp
  end

  def contact_by_id(contact_id)
  	contact_list[contact_id]
  end

  private

  attr_reader :console, :contact_list

end