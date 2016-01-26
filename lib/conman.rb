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
      ui.display(contact_list.last)
      answer = ui.ask_for_another
    end
    display_all(contact_list)
  end

  def add_contact
    name    = ui.ask_for_name
    address = ui.ask_for_address
    phone   = ui.ask_for_phone
    email   = ui.ask_for_email
    notes   = ui.ask_for_notes

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

  def display_all(contacts)
    console.print(header)
    contacts.each do |contact|
      ui.display(contact)
    end
  end

  def header
    "\nNAME\tADDRESS\tPHONE\tEMAIL\tNOTES\n"
  end

  private

  attr_reader :console, :ui, :contact_list

end