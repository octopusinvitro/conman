class Finder

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
  end

  def search_contacts
    loop do
      display_names(search_contact(ask_for_term))
      break unless ask_search_again
    end
  end

  def search_contact(term)
    all.select{ |contact| contact.any? {|key, val| val.include?(term)} }
  end

  private

  attr_reader :ui, :contacts

  def ask_for_term
  	ui.ask_for_term
  end

  def display_names(contact_list)
    ui.display_names(contact_list)
  end

  def ask_search_again
  	ui.ask_search_again
  end

  def all
  	contacts.all
  end

end