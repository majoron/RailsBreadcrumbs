require 'spec_helper'

describe RailsBreadcrumbs do
  it "should define rails" do
    ::Rails::VERSION::MAJOR.should be
  end
end
