class UpdaterScreen

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    update_contacts
  end

  def update_contacts
    display
    contact = ask_for_contact
  end

  private

  attr_reader :ui, :db

  def all
    db.all
  end

  def display_all
    ui.display_all_with_index(all)
  end

  def ask_for_contact
    ui.ask_for_contact_to_edit
  end

end