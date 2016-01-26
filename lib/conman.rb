require 'console'

class Conman

  def initialize(console, ui)
    @console      = console
    @ui           = ui
    @contact_list = []
  end

  def run
    answer = "y"
    while answer == "y"
      add_contact
      display(contact_list.last)
      answer = ui.ask_for_another
    end
    display_all(contact_list)
  end

  def add_contact
    name    = ui.ask_for_name
    address = ui.ask_for_address
    email   = ask_for_email
    notes   = ask_for_notes
    phone   = ui.ask_for_phone

    contact = {}
    contact[:name]    = name
    contact[:address] = address
    contact[:phone]   = phone
    contact[:email]   = email
    contact[:notes]   = notes
    contact_list << contact
  end

  def contact_of_id(contact_id)
    contact_list[contact_id]
  end

  def total_contacts
    contact_list.size
  end

  def display(contact)
    console.print(contact[:name] + "\t" + 
      contact[:address] + "\t" +
      contact[:phone]   + "\t" +
      contact[:email]   + "\t" +
      contact[:notes]   + "\n")
  end

  def display_all(contacts)
    console.print(header)
    contacts.each do |contact|
      display(contact)
    end
  end

  def header
    "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"
  end

  private

  attr_reader :console, :ui, :contact_list

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

end