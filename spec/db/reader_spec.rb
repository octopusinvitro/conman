require 'db/reader'

describe Reader do

  let(:contents)  {'[
    {"name":"name1","address":"address1"},
    {"name":"name2","address":"address2"},
    {"name":"name3","address":"address3"}
  ]'}

  let (:contacts) {[
    {"name"=>"name1", "address"=>"address1"},
    {"name"=>"name2", "address"=>"address2"},
    {"name"=>"name3", "address"=>"address3"}
  ]}

  it "obtains an empty array if file is empty" do
    file   = StringIO.new("")
    reader = described_class.new(file)
    expect(reader.run).to eq([])
  end

  it "obtains an array of contacts with the right format" do
    file   = StringIO.new(contents)
    reader = described_class.new(file)
    expect(reader.run).to eq(contacts)
  end

  it "reads from the beginning of the file" do
    file   = StringIO.new(contents)
    reader = described_class.new(file)
    file.seek(1)
    expect(reader.run).to eq(contacts)
  end

end