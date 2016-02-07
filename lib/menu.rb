class Menu

  def initialize(ui, actions)
    @ui      = ui
    @actions = actions
  end

  def ask_menu_option
  	ui.ask_menu_option(create_menu)
  end

  def create_menu
  	menu = []
  	(0...size).each { |i| menu << item(i) }
  	menu
  end

  def exit?(option)
    option == size
  end

  def check(option)
    actions.each { |action| action.last.run if selected?(option, action) }
  end

  private

  attr_reader :ui, :actions

  def size
  	actions.size
  end

  def item(i)
    [i + 1, actions[i].first]
  end

  def selected?(option, action)
    option == actions.index(action) + 1
  end

end