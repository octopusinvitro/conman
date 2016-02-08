require 'db/writer'

describe Writer do

  let (:contacts) {[
    {"name"=>"name1", "address"=>"address1"},
    {"name"=>"name2", "address"=>"address2"},
    {"name"=>"name3", "address"=>"address3"}
  ]}

  let(:contents) {'[{"name":"name1","address":"address1"},{"name":"name2","address":"address2"},{"name":"name3","address":"address3"}]'}

  it "replaces the contents of the file" do
    file        = StringIO.new(contents)
    one_contact = [{"name"=>"name1", "address"=>"address1"}]
    writer      = described_class.new(file)
    writer.run(one_contact)
    expect(file.string).to eq('[{"name":"name1","address":"address1"}]')
  end

  it "saves the contents of the file in JSON format" do
    file   = StringIO.new("")
    writer = described_class.new(file)
    writer.run(contacts)
    expect(file.string).to eq(contents)
  end

  it "flushes the contents to the file" do
    file   = instance_double(File).as_null_object
    writer = described_class.new(file)
    writer.run(contacts)
    expect(file).to have_received(:flush).once
  end

end