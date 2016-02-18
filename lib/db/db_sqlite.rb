require 'db/db'
require 'sqlite3'

class DBSQLite < DB

  def initialize(sqlite, table, columns)
    @sqlite  = sqlite
    @table   = table
    @columns = columns
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
    sql = "INSERT INTO #{table} #{field_columns} VALUES(#{field_values(contact)})"
    sqlite.execute sql
  end

  def update(contact)
    sql = "UPDATE #{table} SET #{field_setters(contact)} WHERE id=#{contact["id"]}"
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
    sql = "CREATE TABLE IF NOT EXISTS #{table} (id INTEGER PRIMARY KEY, #{fields})"
    sqlite.execute sql
  end

  def columns_with_id
    (["id"] << columns).flatten
  end

  def fields
    cols = ""
    columns.each { |column| cols << "#{column} TEXT, " }
    cols.chomp(", ")
  end

  def field_columns
    cols = "("
    columns.each { |column| cols << "#{column}, " }
    cols.chomp(", ") << ")"
  end

  def field_values(contact)
    values = ""
    columns.each { |column| values << "'#{contact[column]}', " }
    values.chomp(", ")
  end

  def field_setters(contact)
    setters = ""
    columns.each { |column| setters << "#{column}='#{contact[column]}', " }
    setters.chomp(", ")
  end

end
