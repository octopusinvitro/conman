# frozen_string_literal: true

require 'screens/action'

class Terminator < Action
  def initialize(ui, db, kernel = Kernel) # rubocop:disable Naming/UncommunicativeMethodParamName, Metrics/LineLength
    @ui     = ui
    @db     = db
    @kernel = kernel
  end

  def run
    super
    terminate
  end

  private

  attr_reader :ui, :db, :kernel

  def bye
    ui.bye
  end

  def close
    db.close
  end

  def exit
    kernel.exit
  end

  def terminate
    bye
    close
    exit
  end
end
