# frozen_string_literal: false

require 'db/json_file'

RSpec.describe JSONFile do
  let(:contacts) do
    [
      { 'name' => 'name1', 'address' => 'address1' },
      { 'name' => 'name2', 'address' => 'address2' },
      { 'name' => 'name3', 'address' => 'address3' }
    ]
  end

  let(:contents) do
    '[{"name":"name1","address":"address1"}, ' \
    '{"name":"name2","address":"address2"}, ' \
    '{"name":"name3","address":"address3"}]'
  end

  it 'obtains an empty array if file is empty' do
    file     = StringIO.new('')
    jsonfile = described_class.new(file)
    expect(jsonfile.read_json).to eq([])
  end

  it 'obtains an array of contacts with the right format' do
    file     = StringIO.new(contents)
    jsonfile = described_class.new(file)
    expect(jsonfile.read_json).to eq(contacts)
  end

  it 'reads from the beginning of the file' do
    file     = StringIO.new(contents)
    jsonfile = described_class.new(file)
    file.seek(1)
    expect(jsonfile.read_json).to eq(contacts)
  end

  it 'replaces the contents of the file' do
    file        = StringIO.new(contents)
    one_contact = [{ 'name' => 'name1', 'address' => 'address1' }]
    jsonfile    = described_class.new(file)
    jsonfile.write_json(one_contact)
    expect(file.string).to eq('[{"name":"name1","address":"address1"}]')
  end

  it 'saves the contents of the file in JSON format' do
    file     = StringIO.new('')
    jsonfile = described_class.new(file)
    jsonfile.write_json(contacts)
    expect(file.string).to eq(contacts.to_json)
  end

  it 'flushes the contents to the file' do
    file     = instance_double(File).as_null_object
    jsonfile = described_class.new(file)
    jsonfile.write_json(contacts)
    expect(file).to have_received(:flush)
  end

  it 'closes the file' do
    file     = StringIO.new('')
    jsonfile = described_class.new(file)
    jsonfile.close
    expect(file.closed?).to eq(true)
  end
end
