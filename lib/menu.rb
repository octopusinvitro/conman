require 'ui'

class Menu

  def initialize(ui)
    @ui = ui
  end

  def display
  	menu = [["1", "Add new contact", "2"], ["Search contact"]]
  	ui.display_menu(menu)
  end

  private

  attr_reader :ui

end