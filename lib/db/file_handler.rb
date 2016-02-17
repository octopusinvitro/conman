require 'json'

class FileHandler

  def initialize(file)
    @file = file
  end

  def read
    file.rewind
    parse(file.read)
  end

  def write(contacts)
    file.truncate(0)
    file.write(contacts.to_json)
    file.flush
  end

  private

  attr_reader :file

  def parse(contacts)
    contacts == '' ? [] : JSON.parse(contacts)
  end

end