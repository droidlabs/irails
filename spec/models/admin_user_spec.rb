require 'spec_helper'

describe AdminUser do
  it { should validate_presence_of :email }
end
