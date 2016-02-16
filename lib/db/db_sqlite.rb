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
    columns  = ["id", "name", "address", "phone", "email", "notes"]
    contacts = sqlite.execute "SELECT * FROM contacts"
    contacts.map { |contact| Hash[columns.zip(contact)] }
  end

  def at(index)
  end

  def add(contact)
    sql = "INSERT INTO contacts (name, address, phone, email, notes) VALUES('" << contact["name"] << "','" << contact["address"] << "','" << contact["phone"] << "','" << contact["email"] << "','" << contact["notes"] << "')"
    sqlite.execute sql
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
