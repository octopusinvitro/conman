require 'json'

class Reader

  def initialize(file)
    @file = file
  end

  def read_contacts
    parse(read)
  end

  private

  attr_reader :file

  def read
    file.read
  end

  def parse(contacts)
    contacts == '' ? [] : JSON.parse(contacts)
  end

end