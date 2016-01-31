require 'lister'
require 'ui'
require 'db'

describe Lister do

  let (:ui) {instance_double(UI).as_null_object}

  it "prints a message if no available contacts" do
    db     = DB.new
    lister = Lister.new(ui, db)
    lister.act
    expect(ui).to have_received(:error_no_contacts).once
  end

  it "displays a list of contacts if there are any" do
    db     = DB.new([{name: "name"}])
    lister = Lister.new(ui, db)
    lister.act
    expect(ui).to have_received(:display_all).once
  end

end