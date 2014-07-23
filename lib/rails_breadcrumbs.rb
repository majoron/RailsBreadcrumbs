# Include
require 'rubygems'
require 'active_support'
require 'rails_breadcrumbs/model_additions'
require 'rails_breadcrumbs/controller_additions'
require 'rails_breadcrumbs/view_additions'

# = Rails breadcrumbs
#
module RailsBreadcrumbs
  # ::Rails.logger.error("...")

  # default options that can be overridden on the global level
  @@options = {
      :locale_root              => 'navigation.breadcrumbs.', #
      :home_path                => '/welcome',                #
      :home_label               => 'Home',                    #
      :item_separator           => ' &gt;',                   #
      :css_class                => 'breadcrumbs',             #
      :fist_item_css_class      => 'first_breadcrumb_item',   #
      :last_item_css_class      => 'last_breadcrumb_item',    #
      :make_last_item_as_link   => true,                      #
      :include_home_icon        => true,                      #
      :include_home_label       => false,                     #
      :url_options              => {}                         #
  }
  mattr_reader :options


  def self.enable_activerecord
    ActiveRecord::Base.send :include, RailsBreadcrumbs::ModelAdditions
  end

  def self.enable_actionpack
    ActionController::Base.send :include, RailsBreadcrumbs::ControllerAdditions

    ActionView::Base.send :include, RailsBreadcrumbs::ViewAdditions
  end
end

if defined? Rails
  RailsBreadcrumbs.enable_activerecord if defined? ActiveRecord
  RailsBreadcrumbs.enable_actionpack if defined? ActionController
end
