require 'json'

class Writer

  def initialize(file)
    @file = file
  end

  def run(contacts)
    file.truncate(0)
    file.write(contacts.to_json)
    file.flush
  end

  private

  attr_reader :file

end