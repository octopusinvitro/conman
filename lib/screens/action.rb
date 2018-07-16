# frozen_string_literal: true

class Action
  def initialize(ui) # rubocop:disable Naming/UncommunicativeMethodParamName
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
