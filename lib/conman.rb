class Conman

  def initialize(menu, actions)
    @menu    = menu
    @actions = actions
  end

  def start
    clear
    loop do
      body
    end
  end

  def body
    option = ask_menu_option
    choose(option)
  end

  private

  attr_reader :menu, :actions

  def clear
    menu.clear
  end

  def ask_menu_option
    menu.ask_menu_option
  end

  def choose(option)
    actions.each { |action| action.run if selected?(option, action) }
  end

  def selected?(option, action)
    actions.index(action) == option - 1
  end

end