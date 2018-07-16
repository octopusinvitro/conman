# frozen_string_literal: true

require 'db/writer'
require 'json'

RSpec.describe Writer do
  let(:contacts) do
    [
      { 'name' => 'name1', 'address' => 'address1' },
      { 'name' => 'name2', 'address' => 'address2' },
      { 'name' => 'name3', 'address' => 'address3' }
    ]
  end

  let(:contents) do
    %(
      [
        {"name":"name1","address":"address1"},
        {"name":"name2","address":"address2"},
        {"name":"name3","address":"address3"}
      ]
    )
  end

  it 'replaces the contents of the file' do
    file        = StringIO.new(contents)
    one_contact = [{ 'name' => 'name1', 'address' => 'address1' }]
    writer      = described_class.new(file)
    writer.write(one_contact)
    expect(file.string).to eq('[{"name":"name1","address":"address1"}]')
  end

  it 'saves the contents of the file' do
    file   = StringIO.new('')
    writer = described_class.new(file)
    writer.write(contacts)
    expect(file.string).to eq(contents)
  end

  it 'saves the contents of the file in JSON format' do
    file   = StringIO.new('')
    writer = described_class.new(file)
    writer.write(contacts)
    expect(file.string).to eq(contacts.to_json)
  end

  it 'flushes the contents to the file' do
    file   = instance_double(File).as_null_object
    writer = described_class.new(file)
    writer.write(contacts)
    expect(file).to have_received(:flush)
  end
end
