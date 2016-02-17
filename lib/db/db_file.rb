require 'db/db'

class DBFile < DB

  def initialize(filehandler)
    @filehandler = filehandler
  end

  def size
    all.size
  end

  def all
    filehandler.read
  end

  def at(index)
    all.fetch(index, {})
  end

  def add(contact)
    filehandler.write(all << add_id_to(contact))
  end

  def update(contact)
    filehandler.write(update_with(add_id_to(contact)))
  end

  def search(term)
    all.select { |contact| contact.any? {|key, val| val.to_s.include?(term)} }
  end

  def index_of_id(id)
    all.index { |contact| contact["id"] == id }
  end

  def close
    filehandler.close
  end

  private

  attr_reader :filehandler

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

  def update_with(contact)
    index = index_of_id(contact["id"])
    invalid?(index) ? add_contact(contact) : update_contact(contact, index)
  end

  def add_contact(contact)
    contacts = all
    contacts << contact
  end

  def update_contact(contact, index)
    contacts = all
    contacts[index] = contact
    contacts
  end

end
