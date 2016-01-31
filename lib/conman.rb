class Conman

  def initialize(menu)
    @menu = menu
  end

  def run
    loop do
      option = ask_menu_option
      break if exit(option)
      check(option)
    end
  end

  private

  attr_reader :menu

  def ask_menu_option
    menu.ask_menu_option
  end

  def exit(option)
    menu.exit(option)
  end

  def check(option)
    menu.check(option)
  end

end