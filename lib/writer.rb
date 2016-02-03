require 'json'

class Writer

  def initialize(file)
    @file = file
  end

  def write_contacts(contacts)
  	file.write(parse(contacts))
  end

  private

  attr_reader :file

  def parse(contacts)
    contacts.to_json
  end

end