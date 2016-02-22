require 'actions/updater'

describe Updater do

  let(:ui)       {instance_double(UI).as_null_object}
  let(:db)       {instance_double(DBFile).as_null_object}
  let(:updater)  {described_class.new(ui, db)}
  let(:contacts) {[
    {"id" => 1, "name" => "name1", "address" => "address1"},
    {"id" => 2, "name" => "name2", "address" => "address2"},
    {"id" => 3, "name" => "name3", "address" => "address3"}
  ]}

  before :each do
    allow(ui).to receive(:ask_for_contact_to_edit).and_return(0)
    allow(ui).to receive(:ask_for_field_to_edit).and_return(1)
    allow(ui).to receive(:ask_another_field).and_return(false)
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
    updater.run
    expect(ui).to have_received(:display_fields_with_index).once
  end

  it "chooses a field to edit" do
    updater.run
    expect(ui).to have_received(:ask_for_field_to_edit).once
  end

  it "asks for the value of the field to edit" do
    allow(ui).to receive(:ask_for_value_to_edit).and_return("new name")
    updater.run
    expect(ui).to have_received(:ask_for_value_to_edit).once
  end

  it "saves the updated contact to the DB" do
    allow(ui).to receive(:ask_for_value_to_edit).and_return("new name")
    updater.run
    expect(db).to have_received(:update).once
    expect(db.at(0)["name"]).to eq("new name")
  end

  it "displays the updated contact details" do
    updater.run
    expect(ui).to have_received(:display_all).once
  end

  it "asks to edit another field" do
    updater.run
    expect(ui).to have_received(:ask_another_field).once
  end

  it "edits two fields" do
    allow(ui).to receive(:ask_another_field).and_return(true, false)
    updater.run
    expect(ui).to have_received(:ask_another_field).twice
  end

end