require 'conman'

describe Conman do

  let (:input)   {StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes\n")}
  let (:output)  {StringIO.new}
  let (:console) {Console.new(input, output)}
  let (:ui)      {UI.new(console)}
  let (:conman)  {Conman.new(console, ui)}

  it "saves the name introduced by the user" do
    conman.add_contact
    expect(conman.contact_of_id(0)[:name]).to eq("name")
  end

  it "saves the address introduced by the user" do
    conman.add_contact
    expect(conman.contact_of_id(0)[:address]).to eq("address")
  end

  it "saves the phone introduced by the user" do
    conman.add_contact
    expect(conman.contact_of_id(0)[:phone]).to eq("123456")
  end

  it "saves the email introduced by the user" do
    conman.add_contact
    expect(conman.contact_of_id(0)[:email]).to eq("email@mail.com")
  end

  it "saves the notes introduced by the user" do
    conman.add_contact
    expect(conman.contact_of_id(0)[:notes]).to eq("notes")
  end

  it "adds a contact through a loop" do
    input.string << "y\n"
    input.string << "name\naddress\n123456\nemail@mail.com\nnotes\n"
    input.string << "n\n"
    conman.run
    expect(conman.total_contacts).to eq(2)
  end

  it "prints contact after adding it" do
    input.string << "n\n"
    conman.run
    expect(output.string).to include("name\taddress\t123456\temail@mail.com\tnotes\n")
  end

  it "prints all contacts" do
    contacts = []
    contacts << {name: "name1", address: "address1", phone: "123456", email: "email1@mail.com", notes: "notes1"}
    contacts << {name: "name2", address: "address2", phone: "123456", email: "email2@mail.com", notes: "notes2"}
    conman.display_all(contacts)
    expect(output.string.lines.count).to eq(4)
  end

  it "prints all contacts after finished" do
    input.string << "y\n"
    input.string << "name\naddress\n123456\nemail@mail.com\nnotes\n"
    input.string << "n\n"
    conman.run
    expect(output.string).to include(conman.header)
  end

end
