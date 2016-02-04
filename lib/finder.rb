class Finder

  def initialize(ui, db)
    @ui       = ui
    @contacts = db
  end

  def run
    search_contacts
  end

  def search_contacts
    loop do
      matched = search_contact(ask_for_term)
      display_search_results(matched)
      choose_contact_to_expand(matched)
      break unless ask_search_again
    end
  end

  def search_contact(term)
    all_contacts.select{ |contact| contact.any? {|key, val| val.include?(term)} }
  end

  private

  attr_reader :ui, :contacts

  def ask_for_term
  	ui.ask_for_term
  end

  def display_search_results(contacts)
    ui.display_names(contacts)
  end

  def choose_contact_to_expand(matched)
    expand_contact(matched) if ask_to_expand
  end

  def ask_to_expand
    ui.ask_to_expand
  end

  def expand_contact(matched)
    index = ask_for_contact - 1
    display([matched[index]])
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

  def all_contacts
  	contacts.all
  end

end