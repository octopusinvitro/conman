class UpdaterScreen

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    update_contacts
  end

  def update_contacts
    display_all

    index   = ask_for_contact_index - 1
    contact = contact_at(index)
    display_fields(contact)

    index          = ask_for_field_index
    field          = contact.keys[index]
    contact[field] = ask_for_value_to_edit(field)
  end

  private

  attr_reader :ui, :db

  def all
    db.all
  end

  def contact_at(index)
    db.at(index)
  end

  def ask_for_contact_index
    ui.ask_for_contact_to_edit
  end

  def display_all
    ui.display_all_with_index(all)
  end

  def display_fields(contact)
    ui.display_fields_with_index(contact)
  end

  def ask_for_field_index
    ui.ask_for_field_to_edit
  end

  def ask_for_value_to_edit(field)
    ui.ask_for_value_to_edit(field)
  end
end