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

  it "displays all the contacts with an index" do
    allow(db).to receive(:all).and_return(contacts)
    updater.run
    expect(ui).to have_received(:display_all_with_index).once
  end

  it "asks the user for a contact to edit" do
    updater.run
    expect(ui).to have_received(:ask_for_contact_to_edit)
  end


end