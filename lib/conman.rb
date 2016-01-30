class Conman

  def initialize(ui, creator, finder)
    @ui      = ui
    @creator = creator
    @finder  = finder
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

  private

  attr_reader :ui, :creator, :finder

  def add_contacts
    creator.add_contacts
  end

  def search_contacts
    finder.search_contacts
  end

end