# frozen_string_literal: true

require 'json'

class JSONFile
  def initialize(file)
    @file = file
  end

  def read_json
    file.rewind
    parse(file.read)
  end

  def write_json(contacts)
    file.truncate(0)
    file.write(contacts.to_json)
    file.flush
  end

  def close
    file.close
  end

  private

  attr_reader :file

  def parse(contacts)
    contacts.empty? ? [] : JSON.parse(contacts)
  end
end
