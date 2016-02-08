class DB

  def initialize(reader = nil, writer = nil)
    @reader = reader
    @writer = writer
  end

  def size
    all.size
  end

  def all
    reader.nil? ? [] : reader.read
  end

  def at(index)
    all.fetch(index, {})
  end

  def add(contact)
    writer.write(added_a(contact)) if !writer.nil?
  end

  def update(contact)
    writer.write(updated_with(add_id_to(contact))) if !writer.nil?
  end

  def search(term)
    all.select { |contact| contact.any? {|key, val| val.to_s.include?(term)} }
  end

  def index_of_id(id)
    all.index { |contact| contact["id"] == id }
  end

  private

  attr_reader :reader, :writer

  def invalid?(index)
    index.nil? ? true : all[index].nil?
  end

  def add_id_to(contact)
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

  def added_a(contact)
    all << add_id_to(contact)
  end

  def updated_with(contact)
    index    = index_of_id(contact["id"])
    contacts = all
    invalid?(index) ? contacts << contact : contacts[index] = contact
    contacts
  end

end