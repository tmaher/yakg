require 'spec_helper'

describe Yakg do
  pw_name = SecureRandom.hex 4
  pw_value = SecureRandom.hex 4
  new_pw_name = SecureRandom.hex 4

  it "pre-nukes everything" do
    Yakg.list.each {|x| Yakg.unset x }
    Yakg.list.should eq []
  end
  
  it "confirms nonexistent keys are nil" do
    Yakg.get(pw_name).should be_nil
  end

  it "can create a key" do
    Yakg.set(pw_name, pw_value).should be_true
    Yakg.get(pw_name).should eq pw_value
  end

  it "can list keys" do
    Yakg.set(new_pw_name, SecureRandom.hex(4))
    Yakg.list.should eq [pw_name, new_pw_name]
  end
  
  it "can update keys" do
    new_pw_value = SecureRandom.hex 4
    Yakg.set(pw_name, new_pw_value).should be_true
    Yakg.get(pw_name).should eq new_pw_value
  end

  it "can delete a key" do
    Yakg.unset(pw_name).should be_true
    Yakg.get(pw_name).should be_nil
  end
  
end
