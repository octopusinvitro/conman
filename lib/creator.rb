class Creator

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
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

  attr_reader :ui, :contacts

  def ask_for_fields
    contact = {}
    contact[:name]    = ui.ask_for_name
    contact[:address] = ui.ask_for_address
    contact[:phone]   = ui.ask_for_phone
    contact[:email]   = ui.ask_for_email
    contact[:notes]   = ui.ask_for_notes
    contact
  end

  def add_contact(contact)
    contacts.add(contact)
  end

  def display(contact)
    ui.display(contact)
  end

  def ask_for_another
    ui.ask_for_another
  end

  def all
    contacts.all
  end

  def display_all
  	ui.display_all(all)
  end
end