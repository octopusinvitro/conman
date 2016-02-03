class DB

  def initialize(reader = nil, writer = nil, contact_list = [])
    @reader = reader
    @writer = writer
    @contact_list = contact_list
  end

  def size
    contact_list = all
    contact_list.size
  end

  def add(contact)
    contact_list << contact
    writer.write_contacts(contact_list) if !writer.nil?
  end

  def all
    contacts = reader.nil? ? contact_list : reader.read_contacts
  end

  def at(id)
    contact_list = all
    contact      = contact_list.empty? ? {} : contact_list[id]
  end

  private

  attr_reader :reader, :writer, :contact_list

end