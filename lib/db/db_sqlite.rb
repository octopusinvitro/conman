require 'db/db'
require 'sqlite3'

class DBSQLite < DB

  def initialize(path)
    @sqlite = SQLite3::Database.new path
    sqlite.execute "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT, notes TEXT)"
  end

  def size
  end

  def all
    sqlite.results_as_hash = true
    contacts = sqlite.execute "SELECT * FROM contacts"
  end

  def at(index)
  end

  def add(contact)
  end

  def update(contact)
  end

  def search(term)
  end

  def index_of_id(id)
  end

  private

  attr_reader :sqlite

end
