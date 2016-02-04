require 'db/writer'

describe Writer do

  let (:contacts) {[
    {"name"=>"name1", "address"=>"address1"},
    {"name"=>"name2", "address"=>"address2"},
    {"name"=>"name3", "address"=>"address3"}
  ]}

  let(:contents) {'[{"name":"name1","address":"address1"},{"name":"name2","address":"address2"},{"name":"name3","address":"address3"}]'}
  let (:file)    {instance_double(File).as_null_object}
  let (:writer)  {described_class.new("", file)}

  it "saves contacts to a file" do
    writer.run(contacts)
    expect(file).to have_received(:write).with(contents)
  end

end