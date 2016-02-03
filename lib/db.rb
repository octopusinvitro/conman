class DB

  def initialize(reader = nil, writer = nil)
    @reader = reader
    @writer = writer
  end

  def size
    all.size
  end

  def add(contact)
    contacts = all
    contacts << contact
    writer.write_contacts(contacts) if !writer.nil?
  end

  def all
    reader.nil? ? [] : reader.read_contacts
  end

  def at(id)
    all.empty? ? {} : all[id]
  end

  private

  attr_reader :reader, :writer

end