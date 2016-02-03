require 'lister'

describe Lister do

  let (:ui)     {instance_double(UI).as_null_object}
  let (:db)     {instance_double(DB).as_null_object}
  let (:lister) {described_class.new(ui, db)}

  it "prints an error message if no available contacts" do
    allow(db).to receive(:all).and_return([])
    lister.act
    expect(ui).to have_received(:error_no_contacts).once
  end

  it "displays a list of contacts if there are any" do
    allow(db).to receive(:all).and_return([{name: "name", address: "address"}])
    lister.act
    expect(ui).to have_received(:display_all).once
  end

end