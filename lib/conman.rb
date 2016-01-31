class Conman

  def initialize(ui, actions)
    @ui      = ui
    @actions = actions
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
      break if exit(option)
      check(option)
    end

  end

  private

  attr_reader :ui, :actions

  def ask_menu_option(menu)
    ui.ask_menu_option(menu)
  end

  def exit(option)
    option == actions.size + 1
  end

  def check(option)
    actions.each { |action| action.act if selected(option, action) }
  end

  def selected(option, action)
    option == actions.index(action) + 1
  end

end