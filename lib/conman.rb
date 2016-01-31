require 'creator'
require 'finder'

class Conman

  def initialize(ui, db)
    @ui      = ui
    @db      = db
    @creator = Creator.new(ui, db)
    @finder  = Finder.new(ui, db)
  end

  def run
    menu = [
      [1, "List contacts"],
      [2, "Add contacts"],
      [3, "Search contacts"],
      [4, "Quit"]
    ]

    loop do
      option = ask_menu_option(menu)

      if (option == 1)
        list_contacts
      elsif (option == 2)
        add_contacts
      elsif (option == 3)
        search_contacts
      elsif (option == 4)
        break
      end

    end
  end

  private

  attr_reader :ui, :db, :creator, :finder

  def ask_menu_option(menu)
    ui.ask_menu_option(menu)
  end

  def list_contacts
    ui.display_all(all)
  end

  def add_contacts
    creator.add_contacts
  end

  def search_contacts
    finder.search_contacts
  end

  def all
    db.all
  end

end