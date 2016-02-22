require 'db/db'
require 'sqlite3'

class DBSQLite < DB

  def initialize(sqlite)
    @sqlite  = sqlite
    @table   = "contacts"
    @columns = ["name", "address", "phone", "email", "notes"]
    create_table
  end

  def size
    all.size
  end

  def all
    contacts = sqlite.execute "SELECT * FROM #{table}"
    contacts.map { |contact| Hash[columns_with_id.zip(contact)] }
  end

  def at(index)
    all.fetch(index, {})
  end

  def add(contact)
    sql = "INSERT INTO #{table} (name, address, phone, email, notes) VALUES('#{contact["name"]}', '#{contact["address"]}', '#{contact["phone"]}', '#{contact["email"]}', '#{contact["notes"]}')"
    sqlite.execute sql
  end

  def update(contact)
    sql = "UPDATE #{table} SET name='#{contact["name"]}', address='#{contact["address"]}', phone='#{contact["phone"]}', email='#{contact["email"]}', notes='#{contact["notes"]}' WHERE id=#{contact["id"]}"
    sqlite.execute sql
  end

  def search(term)
    all.select { |contact| contact.any? {|key, val| val.to_s.include?(term)} }
  end

  def index_of_id(id)
    all.index { |contact| contact["id"] == id }
  end

  def close
    sqlite.close
  end

  private

  attr_reader :sqlite, :table, :columns

  def create_table
    sql = "CREATE TABLE IF NOT EXISTS #{table} (id INTEGER PRIMARY KEY, name TEXT, address TEXT, phone TEXT, email TEXT, notes TEXT)"
    sqlite.execute sql
  end

  def columns_with_id
    (["id"] << columns).flatten
  end

end
