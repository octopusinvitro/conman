# frozen_string_literal: false

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
    '[' \
    '{"name":"name1","address":"address1"},' \
    '{"name":"name2","address":"address2"},' \
    '{"name":"name3","address":"address3"}' \
    ']'
  end

  it 'saves the contents of the file' do
    file = StringIO.new
    described_class.new(file).write(contacts)
    expect(file.string).to eq(contents)
  end

  it 'saves the contents of the file in JSON format' do
    file = StringIO.new
    described_class.new(file).write(contacts)
    expect(file.string).to eq(contacts.to_json)
  end

  it 'replaces the contents of the file' do
    file = StringIO.new(contents)
    one_contact = [{ 'name' => 'name1', 'address' => 'address1' }]
    described_class.new(file).write(one_contact)
    expect(file.string).to eq('[{"name":"name1","address":"address1"}]')
  end

  it 'flushes the contents to the file' do
    file = instance_double(File).as_null_object
    described_class.new(file).write(contacts)
    expect(file).to have_received(:flush)
  end

  xit 'works with a real file' do
    File.open('test', 'w') { |file| file.write(contents) }
    file = File.new('test', 'a+')
    one_contact = [{ 'name' => 'name1', 'address' => 'address1' }]
    described_class.new(file).write(one_contact)
    expect(file.read).to eq('[{"name":"name1","address":"address1"}]')
    file.close
    File.delete(file)
  end
end
