require 'spec_helper'

describe RailsBreadcrumbs do
  describe 'config_file_name' do
    context 'for :default navigation_context' do
      it "should return the name of the default config file" do
        RailsBreadcrumbs.config_file_name.should == 'breadcrumbs.rb'
      end
    end

    context 'for :default navigation_context1' do
      it "should return the name of the default config file" do
        RailsBreadcrumbs.config_file_name.should == 'breadcrumbs.rb'
      end
    end

    context 'for :default navigation_context3' do
      it "should return the name of the default config file" do
        RailsBreadcrumbs.config_file_name.should == 'breadcrumbs.rb'
      end
    end

    context 'for :default navigation_context4' do
      it "should return the name of the default config file" do
        RailsBreadcrumbs.config_file_name.should != 'breadcrumbs.rb'
      end
    end

    context 'for :default navigation_context5' do
      it "should return the name of the default config file" do
        RailsBreadcrumbs.config_file_name.should != 'breadcrumbs.rb'
      end
    end
  end
end
