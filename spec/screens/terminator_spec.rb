require 'ui/ui'
require 'db/db_file'
require 'screens/kernel_fake'
require 'screens/terminator'

describe Terminator do

  let(:ui)         {instance_double(UI).as_null_object}
  let(:db)         {instance_double(DBFile).as_null_object}
  let(:kernel)     {KernelFake.new}
  let(:terminator) {described_class.new(ui, db, kernel)}

  it "prints a goodbye message" do
    terminator.run
    expect(ui).to have_received(:bye).once
  end

  it "closes database on exit" do
    terminator.run
    expect(db).to have_received(:close).once
  end

  it "exits the program when called" do
    terminator.run
    expect(kernel.was_exit_called?).to eq(true)
  end

end