class CreatorScreen

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    add_contacts
  end

  def add_contacts
    loop do
      contact = ask_for_fields
      add_contact(contact)
      display(contact)
      break unless ask_for_another
    end

    display_all
  end

  private

  attr_reader :ui, :db

  def ask_for_fields
    ui.ask_for_fields
  end

  def add_contact(contact)
    db.add(contact)
  end

  def display(contact)
    ui.display_all([contact])
  end

  def ask_for_another
    ui.ask_for_another
  end

  def all
    db.all
  end

  def display_all
    ui.display_all(all)
  end
end