require 'console'

class Conman

  def initialize(console)
  	@console = console
  	@contact_list = []
  end

  def add_contact
  	console.print("Contact name: ")
  	name = console.read.chomp

  	console.print("Contact address: ")
  	address = console.read.chomp

    console.print("Contact phone: ")
    phone = console.read.chomp

  	contact = {}
  	contact[:name]    = name
  	contact[:address] = address
  	contact[:phone]   = phone
  	contact_list << contact
  end

  def contact_by_id(contact_id)
  	contact_list[contact_id]
  end

  private

  attr_reader :console, :contact_list

end