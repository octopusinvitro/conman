class Finder

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
  end

  def search_contacts
    loop do
      display_search_results(search_contact(ask_for_term))
      choose_contact_to_expand
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

  def display_search_results(contacts)
    ui.display_names(contacts)
  end

  def choose_contact_to_expand
    expand_contact if ask_to_expand
  end

  def ask_to_expand
    ui.ask_to_expand
  end

  def expand_contact
    index = ask_for_contact - 1
    display([contacts.at(index)])
  end

  def ask_for_contact
    ui.ask_for_contact
  end

  def display(contacts)
    ui.display_all(contacts)
  end

  def ask_search_again
  	ui.ask_search_again
  end

  def all
  	contacts.all
  end

end