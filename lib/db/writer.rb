require 'json'

class Writer

  def initialize(path, file = nil)
    @path = path
    @file = file
  end

  def run(contacts)
    file.nil? ? write(contacts) : tests_write(contacts)
  end

  private

  attr_reader :path, :file

  def parse(contacts)
    contacts.to_json
  end

  def write(contacts)
    File.open(path, "w+") do |f|
      f.write(parse(contacts))
    end
  end

  def tests_write(contacts)
    file.write(parse(contacts))
  end

end