class ListerScreen

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
  end

  def run
    list_all
  end

  def list_all
    all.empty? ? print_error_message : display_all
  end

  private

  attr_reader :ui, :contacts

  def all
    contacts.all
  end

  def print_error_message
  	ui.error_no_contacts
  end

  def display_all
  	ui.display_all(all)
  end

end