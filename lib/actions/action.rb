class Action

  def initialize(ui)
    @ui = ui
  end

  def run
    clear
  end

  private

  attr_reader :ui

  def clear
    ui.clear
  end

end