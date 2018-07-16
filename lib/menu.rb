# frozen_string_literal: true

class Menu
  def initialize(ui, actions) # rubocop:disable Naming/UncommunicativeMethodParamName, Metrics/LineLength
    @ui      = ui
    @actions = actions
  end

  def clear
    ui.clear
  end

  def ask_menu_option
    ui.ask_menu_option(create_menu)
  end

  def create_menu
    menu = []
    (0...actions.size).each { |index| menu << item(index) }
    menu
  end

  private

  attr_reader :ui, :actions

  def item(index)
    [index + 1, actions[index]]
  end
end
