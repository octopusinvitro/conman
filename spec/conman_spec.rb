require 'conman'

describe Conman do

  let (:input)   {StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes\n")}
  let (:output)  {StringIO.new}
  let (:console) {Console.new(input, output)}
  let (:conman)  {Conman.new(console)}

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
    input   = StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes\ny\nname\naddress\n123456\nemail@mail.com\nnotes\nn\n")
    console = Console.new(input, output)
    conman  = Conman.new(console)
    conman.run
    expect(conman.list_size).to eq(2)
  end

  it "prints a contact" do
     contact = {name: "name", address: "address", phone: "123456", email: "email@mail.com", notes: "notes"}
     conman.display(contact)
     expect(output.string).to eq("name\taddress\t123456\temail@mail.com\tnotes\n")   
  end

  it "prints contact after adding it" do
    input   = StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes\nn\n")
    console = Console.new(input, output)
    conman  = Conman.new(console)
    conman.run
    expect(output.string).to include("name\taddress\t123456\temail@mail.com\tnotes\n")
  end

end
