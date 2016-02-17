require 'actions/action'

class Finder < Action

  def initialize(ui, db)
    @ui = ui
    @db = db
  end

  def run
    super
    search_contacts
  end

  def search_contacts
    loop do
      matched = search_contact(ask_for_term)
      expand_or_not(matched)
      break unless ask_search_again
    end
  end

  private

  attr_reader :ui, :db

  def search_contact(term)
    db.search(term)
  end

  def ask_search_again
    ui.ask_search_again
  end

  def ask_to_expand
    ui.ask_to_expand
  end

  def ask_for_contact_index(matched_size)
    ui.ask_for_contact_to_expand(matched_size)
  end

  def ask_for_term
    ui.ask_for_term
  end

  def display_search_results(contacts)
    ui.display_names(contacts)
  end

  def display(contacts)
    ui.display_all(contacts)
  end

  def error_no_contacts
    ui.error_no_contacts
  end

  def expand_or_not(matched)
    matched.empty? ? error_no_contacts : expand(matched)
  end

  def expand(matched)
    display_search_results(matched)
    choose_contact_to_expand(matched)
  end

  def choose_contact_to_expand(matched)
    expand_contact(matched) if ask_to_expand
  end

  def expand_contact(matched)
    index = ask_for_contact_index(matched.size)
    display([matched[index]])
  end

end