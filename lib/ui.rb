require 'console'

class UI

  ADD_ANOTHER = "Add another contact? (y/n): "

  def initialize(console)
    @console = console
  end

  def ask_for_another
    console.print(ADD_ANOTHER)
    console.read.chomp
  end

  private

  attr_reader :console

end