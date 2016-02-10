class KernelFake

  def initialize
    @exit_was_called = false
  end

  def exit
    @exit_was_called = true
  end

  def was_exit_called?
    exit_was_called
  end

  private

  attr_reader :exit_was_called

end