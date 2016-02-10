require 'actions/action'

class Terminator < Action

  def initialize(ui, kernel = Kernel)
    @ui     = ui
    @kernel = kernel
  end

  def run
    super
    terminate
  end

  private

  attr_reader :ui, :kernel

  def bye
    ui.bye
  end

  def exit
    kernel.exit
  end

  def terminate
    bye
    exit
  end

end