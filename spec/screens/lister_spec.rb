require 'ui/ui'
require 'db/db_file'
require 'screens/lister'

describe Lister do

  let(:ui)     {instance_double(UI).as_null_object}
  let(:db)     {instance_double(DBFile).as_null_object}
  let(:lister) {described_class.new(ui, db)}

  it "prints an error message if no available contacts" do
    allow(db).to receive(:all).and_return([])
    lister.run
    expect(ui).to have_received(:error_no_contacts).once
  end

  it "displays a list of contacts if there are any" do
    allow(db).to receive(:all).and_return([{"name" => "name", "address" => "address"}])
    lister.run
    expect(ui).to have_received(:display_all).once
  end

end