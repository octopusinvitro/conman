require 'conman'

describe Conman do

  let (:input)   {StringIO.new("name\naddress\n123456\nemail@mail.com\nnotes\n")}
  let (:output)  {StringIO.new}
  let (:conman)  {Conman.new(UI.new(Console.new(input, output)))}

  it "saves the name introduced by the user" do
    conman.add_contact
    expect_field(:name, "name")
  end

  it "saves the address introduced by the user" do
    conman.add_contact
    expect_field(:address, "address")
  end

  it "saves the phone introduced by the user" do
    conman.add_contact
    expect_field(:phone, "123456")
  end

  it "saves the email introduced by the user" do
    conman.add_contact
    expect_field(:email, "email@mail.com")
  end

  it "saves the notes introduced by the user" do
    conman.add_contact
    expect_field(:notes, "notes")
  end

  it "adds two contacts through the main loop" do
    input.string << "y\n"
    input.string << "name\naddress\n123456\nemail@mail.com\nnotes\n"
    input.string << "n\n"
    conman.run
    expect(conman.total_contacts).to eq(2)
  end

  it "prints contact after adding it" do
    input.string << "n\n"
    conman.run
    expect(output.string).to include("email@mail.com")
  end

  it "prints all contacts after finished" do
    input.string << "y\n"
    input.string << "name\naddress\n123456\nemail@mail.com\nnotes\n"
    input.string << "n\n"
    conman.run
    expect(output.string).to include(UI::HEADER)
  end

  private

  def expect_field(key, value)
    expect(conman.contact_of_id(0)[key]).to eq(value)
  end

end
