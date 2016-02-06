require 'screens/updater'

describe UpdaterScreen do

  let (:ui)       {instance_double(UI).as_null_object}
  let (:db)       {instance_double(DB).as_null_object}
  let (:updater)  {described_class.new(ui, db)}
  let (:contacts) {[
    {"name" => "name1", "address" => "address1"},
    {"name" => "name2", "address" => "address2"},
    {"name" => "name3", "address" => "address3"}
  ]}

  before :each do
    allow(ui).to receive(:ask_for_contact_to_edit).and_return(1)
    allow(ui).to receive(:ask_for_field_to_edit).and_return(1)
    allow(db).to receive(:at).and_return(contacts.first)
  end

  it "displays all the contacts with an index" do
    allow(db).to receive(:all).and_return(contacts)
    updater.run
    expect(ui).to have_received(:display_all_with_index).once
  end

  it "asks the user for a contact to edit" do
    updater.run
    expect(ui).to have_received(:ask_for_contact_to_edit).once
  end

  it "prints the contact's fields with numbers" do
    allow(db).to receive(:at).and_return(contacts.first)
    updater.run
    expect(ui).to have_received(:display_fields_with_index).once
  end

  it "chooses a field to edit" do
    updater.run
    expect(ui).to have_received(:ask_for_field_to_edit).once
  end

  it "asks for the value of the field to edit" do
    allow(ui).to receive(:ask_for_value_to_edit).and_return("name")
    updater.run
    expect(ui).to have_received(:ask_for_value_to_edit).with("name")
  end

end