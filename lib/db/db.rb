class DB

  def initialize(reader = nil, writer = nil)
    @reader = reader
    @writer = writer
  end

  def size
    all.size
  end

  def all
    reader.nil? ? [] : reader.run
  end

  def at(index)
    empty || invalid(index) ? {} : all[index]
  end

  def add(contact)
    contacts = all << format(contact)
    writer.run(contacts) if !writer.nil?
  end

  def update(contact)
    contacts = updated_with(format(contact))
    writer.run(contacts) if !writer.nil?
  end

  def search(term)
    all.select { |contact| contact.any? {|key, val| val.to_s.include?(term)} }
  end

  def index_of_id(id)
    all.index { |contact| contact["id"] == id }
  end

  private

  attr_reader :reader, :writer

  def empty
    all.empty?
  end

  def invalid(index)
    index.nil? ? true : all[index].nil?
  end

  def format(contact)
    contact.has_key?("id") ? contact : append_id(contact, id_of_new)
  end

  def append_id(contact, id)
    contact_with_id       = {}
    contact_with_id["id"] = id
    contact_with_id.merge!(contact)
  end

  def id_of_new
    size == 0 ? 1 : at(size - 1)["id"] + 1
  end

  def updated_with(contact)
    index    = index_of_id(contact["id"])
    contacts = all
    invalid(index) ? contacts << contact : contacts[index] = contact
    contacts
  end

end