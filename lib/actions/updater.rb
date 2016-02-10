class Updater

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    clear
    update_contacts
  end

  def update_contacts
    contact = choose_contact
    loop do
      field = choose_field(contact)
      update_field(contact, field)
      display(contact)
      break unless ask_another_field
    end
  end

  private

  attr_reader :ui, :db

  def all
    db.all
  end

  def size
    db.size
  end

  def contact_at(index)
    db.at(index)
  end

  def update(contact)
    db.update(contact)
  end

  def clear
    ui.clear
  end

  def ask_another_field
    ui.ask_another_field
  end

  def ask_for_contact_index
    ui.ask_for_contact_to_edit(size)
  end

  def ask_for_field_index
    ui.ask_for_field_to_edit
  end

  def ask_for_value_to_edit(field)
    ui.ask_for_value_to_edit(field)
  end

  def display_all
    ui.display_all_with_index(all)
  end

  def display_fields(contact)
    ui.display_fields_with_index(contact)
  end

  def display(contact)
    ui.display_all([contact])
  end

  def choose_contact
    display_all
    contact_at(ask_for_contact_index)
  end

  def choose_field(contact)
    display_fields(contact)
    contact.keys[ask_for_field_index]
  end

  def update_field(contact, field)
    contact[field] = ask_for_value_to_edit(field)
    update(contact)
  end

end