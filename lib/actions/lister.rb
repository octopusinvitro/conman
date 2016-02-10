require 'actions/action'

class Lister < Action

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    super
    list_all
  end

  def list_all
    all.empty? ? print_error_message : display_all
  end

  private

  attr_reader :ui, :db

  def all
    db.all
  end

  def print_error_message
  	ui.error_no_contacts
  end

  def display_all
  	ui.display_all(all)
  end

end