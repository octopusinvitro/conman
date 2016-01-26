require 'conman'

describe Conman do

  let (:input)   {StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes")}
  let (:output)  {StringIO.new}
  let (:console) {Console.new(input, output)}
  let (:conman)  {Conman.new(console)}

  it "saves the name introduced by the user" do
    conman.add_contact
    expect(conman.contact_by_id(0)[:name]).to eq("name")
  end

  it "saves the address introduced by the user" do
    conman.add_contact
    expect(conman.contact_by_id(0)[:address]).to eq("address")
  end

  it "saves the phone introduced by the user" do
  	conman.add_contact
  	expect(conman.contact_by_id(0)[:phone]).to eq("123456")
  end

  it "saves the email introduced by the user" do
  	conman.add_contact
  	expect(conman.contact_by_id(0)[:email]).to eq("email@mail.com")
  end

  it "saves the notes introduced by the user" do
  	conman.add_contact
  	expect(conman.contact_by_id(0)[:notes]).to eq("notes")
  end
end