class DB

  def initialize(contact_list = [])
    @contact_list = contact_list
  end

  def size
    contact_list.size
  end

  def add(contact)
    contact_list << contact
  end

  def all
    contact_list
  end

  def at(id)
    contact_list[id]
  end

  private

  attr_reader :contact_list

end