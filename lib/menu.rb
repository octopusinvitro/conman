class Menu

  def initialize(ui, actions)
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
    (0...actions.size).each { |i| menu << item(i) }
  	menu
  end

  private

  attr_reader :ui, :actions

  def item(i)
    [i + 1, actions[i]]
  end

end