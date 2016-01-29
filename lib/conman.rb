require 'console'

class Conman

  def initialize(ui, contact_list)
    @ui           = ui
    @contact_list = contact_list
  end

  def run
    add_contacts
    search_contacts
  end

  def add_contacts
    add_another = true

    while add_another == true
      add_contact
      ui.display(contact_list.last)
      add_another = ui.ask_for_another
    end

    ui.display_all(contact_list)
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

  def search_contacts
    search_again = true

    while search_again == true
      ui.display_all(search_contact)
      search_again = ui.ask_search_again
    end
  end

  def search_contact
    term = ui.ask_for_term
    contact_list.select{ |contact| contact.any? {|key, val| val.include?(term)} }
  end

  private

  attr_reader :ui, :contact_list

end