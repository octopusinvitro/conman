require 'ui'

class Menu

  def initialize(ui)
    @ui = ui
  end

  def ask_menu_option(menu)
    ui.ask_menu_option(menu)
  end

  private

  attr_reader :ui

end