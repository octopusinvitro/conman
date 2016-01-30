class Conman

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
  end

  def run
    menu = [
      [1, "Add contacts"],
      [2, "Search contacts"],
      [3, "Quit"]
    ]

    loop do
      option = ui.ask_menu_option(menu)

      if (option == 1)
        add_contacts
      elsif (option == 2)
        search_contacts
      elsif (option == 3)
        break
      end

    end
  end

  def add_contacts
    loop do
      contact = ask_for_fields
      add_contact(contact)
      ui.display(contact)
      break unless ui.ask_for_another
    end

    ui.display_all(contacts.all)
  end


  def contact_of_id(contact_id)
    contacts.at(contact_id)
  end

  def total_contacts
    contacts.size
  end

  def search_contacts
    loop do
      ui.display_all(search_contact(ui.ask_for_term))
      break unless ui.ask_search_again
    end
  end

  def search_contact(term)
    contacts.all.select{ |contact| contact.any? {|key, val| val.include?(term)} }
  end

  private

  attr_reader :ui, :contacts

  def add_contact(contact)
    contacts.add(contact)
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