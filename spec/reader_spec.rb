require 'reader'

describe Reader do

  let (:file)     {instance_double(File).as_null_object}
  let (:reader)   {described_class.new("", file)}

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
    allow(file).to receive(:read).and_return('')
    expect(reader.run).to eq([])
    expect(file).to have_received(:read).once
  end

  it "obtains an array of contacts with the right format" do
    allow(file).to receive(:read).and_return(contents)
    expect(reader.run).to eq(contacts)
    expect(file).to have_received(:read).once
  end

end