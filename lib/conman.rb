class Conman

  def initialize(ui, db, creator)
    @ui       = ui
    @contacts = db
    @creator  = creator
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

  attr_reader :ui, :contacts, :creator

  def add_contacts
    creator.add_contacts
  end
end