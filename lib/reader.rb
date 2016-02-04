require 'json'

class Reader

  def initialize(path, file = nil)
    @path = path
    @file = file
  end

  def run
    file.nil? ? parse(read) : parse(tests_read)
  end

  private

  attr_reader :path, :file

  def parse(contacts)
    contacts == '' ? [] : JSON.parse(contacts)
  end

  def read
    file = File.open(path, "r")
    contacts = file.read
    file.close
    contacts
  end

  def tests_read
    file.read
  end

end