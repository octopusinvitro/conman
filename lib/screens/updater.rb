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
  end

  private

  attr_reader :ui, :db

  def all
    db.all
  end

  def display
    ui.display_all_with_index(all)
  end

end