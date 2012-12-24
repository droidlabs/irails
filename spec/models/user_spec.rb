require 'spec_helper'

describe User do
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :email }

  context "user avatar" do
    let(:subject) { FactoryGirl.create(:user) }
    it "should set user's avatar" do
      subject.avatar = File.open(Rails.root.join('spec/fixtures/image.png'))
      subject.save
      subject.avatar.exists?.should be_true
    end
  end
end