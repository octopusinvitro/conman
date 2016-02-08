require 'json'

class Reader

  def initialize(file)
    @file = file
  end

  def read
    file.rewind
    parse(file.read)
  end

  private

  attr_reader :file

  def parse(contacts)
    contacts == '' ? [] : JSON.parse(contacts)
  end

end