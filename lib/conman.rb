
class Conman

  def initialize(ui, contact_list = [])
    @ui           = ui
    @contact_list = contact_list
  end

  def run
    add_contacts
    search_contacts
  end

  def add_contacts
    loop do
      contact = ask_for_fields
      add_contact(contact)
      ui.display(contact)
      break unless ui.ask_for_another
    end

    ui.display_all(contact_list)
  end


  def contact_of_id(contact_id)
    contact_list[contact_id]
  end

  def total_contacts
    contact_list.size
  end

  def search_contacts
    loop do
      ui.display_all(search_contact)
      break unless ui.ask_search_again
    end
  end

  def search_contact
    contact_list.select{ |contact| contact.any? {|key, val| val.include?(ui.ask_for_term)} }
  end

  private

  attr_reader :ui, :contact_list

  def add_contact(contact)
    contact_list << contact
  end

  def ask_for_fields
    contact = {}
    contact[:name]    = ui.ask_for_name
    contact[:address] = ui.ask_for_address
    contact[:phone]   = ui.ask_for_phone
    contact[:email]   = ui.ask_for_email
    contact[:notes]   = ui.ask_for_notes
    contact
  end

end