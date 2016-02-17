require 'db/db'
require 'sqlite3'

class DBSQLite < DB

  def initialize(path)
    @sqlite = SQLite3::Database.new path
    sqlite.execute "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT, notes TEXT)"
  end

  def size
    all.size
  end

  def all
    columns  = ["id", "name", "address", "phone", "email", "notes"]
    contacts = sqlite.execute "SELECT * FROM contacts"
    contacts.map { |contact| Hash[columns.zip(contact)] }
  end

  def at(index)
    all.fetch(index, {})
  end

  def add(contact)
    sql = "INSERT INTO contacts (name, address, phone, email, notes) VALUES('" << contact["name"] << "','" << contact["address"] << "','" << contact["phone"] << "','" << contact["email"] << "','" << contact["notes"] << "')"
    sqlite.execute sql
  end

  def update(contact)
    sql = "UPDATE contacts SET name='" << contact["name"] << "', address='" << contact["address"] << "', phone='" << contact["phone"] << "', email='" << contact["email"] << "', notes='" << contact["notes"] << "' WHERE id=" << contact["id"].to_s
    sqlite.execute sql
  end

  def search(term)
    all.select { |contact| contact.any? {|key, val| val.to_s.include?(term)} }
  end

  def index_of_id(id)
  end

  private

  attr_reader :sqlite

end
