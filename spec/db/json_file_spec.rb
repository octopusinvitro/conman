require 'db/json_file'

describe JSONFile do

  let(:contacts) {[
    {"name"=>"name1", "address"=>"address1"},
    {"name"=>"name2", "address"=>"address2"},
    {"name"=>"name3", "address"=>"address3"}
  ]}

  let(:contents) {'[{"name":"name1","address":"address1"},{"name":"name2","address":"address2"},{"name":"name3","address":"address3"}]'}

  it "obtains an empty array if file is empty" do
    file    = StringIO.new("")
    handler = described_class.new(file)
    expect(handler.read_json).to eq([])
  end

  it "obtains an array of contacts with the right format" do
    file    = StringIO.new(contents)
    handler = described_class.new(file)
    expect(handler.read_json).to eq(contacts)
  end

  it "reads from the beginning of the file" do
    file    = StringIO.new(contents)
    handler = described_class.new(file)
    file.seek(1)
    expect(handler.read_json).to eq(contacts)
  end

  it "replaces the contents of the file" do
    file        = StringIO.new(contents)
    one_contact = [{"name"=>"name1", "address"=>"address1"}]
    handler     = described_class.new(file)
    handler.write_json(one_contact)
    expect(file.string).to eq('[{"name":"name1","address":"address1"}]')
  end

  it "saves the contents of the file in JSON format" do
    file    = StringIO.new("")
    handler = described_class.new(file)
    handler.write_json(contacts)
    expect(file.string).to eq(contacts.to_json)
  end

  it "flushes the contents to the file" do
    file    = instance_double(File).as_null_object
    handler = described_class.new(file)
    handler.write_json(contacts)
    expect(file).to have_received(:flush)
  end

  it "closes the file" do
    file    = StringIO.new("")
    handler = described_class.new(file)
    handler.close
    expect(file.closed?).to eq(true)
  end

end
