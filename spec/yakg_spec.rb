require 'spec_helper'

describe Yakg do
  pw_name = SecureRandom.hex 4
  pw_value = SecureRandom.hex 4
  new_pw_name = SecureRandom.hex 4

  it "pre-nukes everything" do
    Yakg.list.each {|x| Yakg.unset x }
    expect(Yakg.list).to eq []
  end

  it "confirms nonexistent keys are nil" do
    expect(Yakg.get(pw_name)).to be nil
  end

  it "can create a key" do
    expect(Yakg.set(pw_name, pw_value)).to be true
    expect(Yakg.get(pw_name)).to eq pw_value
  end

  it "can list keys" do
    Yakg.set(new_pw_name, SecureRandom.hex(4))
    expect(Yakg.list).to eq [pw_name, new_pw_name]
  end

  it "can update keys" do
    new_pw_value = SecureRandom.hex 4
    expect(Yakg.set(pw_name, new_pw_value)).to be true
    expect(Yakg.get(pw_name)).to eq new_pw_value
  end

  it "can delete a key" do
    expect(Yakg.unset(pw_name)).to be true
    expect(Yakg.get(pw_name)).to be nil
  end

  it "has unset return nil for nonexistent keys" do
    expect(Yakg.unset(SecureRandom.hex(8))).to be nil
  end

end
