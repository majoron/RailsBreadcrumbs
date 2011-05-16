# Include
require 'rubygems'
require 'active_support'
require 'rails_breadcrumbs/model_additions'
require 'rails_breadcrumbs/controller_additions'
require 'rails_breadcrumbs/view_additions'

# = Rails breadcrumbs
#
module RailsBreadcrumbs
  def self.enable_activerecord
    ActiveRecord::Base.class_eval do
      include RailsBreadcrumbs::ModelAdditions
    end
  end

  def self.enable_actionpack
    ActionController::Base.class_eval do
      include RailsBreadcrumbs::ControllerAdditions
    end
    ActionView::Base.class_eval do
      include RailsBreadcrumbs::ViewAdditions
    end
  end
end

if defined? Rails
  RailsBreadcrumbs.enable_activerecord if defined? ActiveRecord
  RailsBreadcrumbs.enable_actionpack if defined? ActionController
end
