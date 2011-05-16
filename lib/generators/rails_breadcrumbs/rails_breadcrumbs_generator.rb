module RailsBreadcrumbs
  module Generators
    class RailsBreadcrumbsGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_rails_breadcrumbs
        copy_file "home.png", "public/images/breadcrumbs/home.png"
        copy_file "rails_breadcrumbs.css", "public/stylesheets/rails_breadcrumbs.css"
        copy_file "rails_breadcrumbs.sass", "public/stylesheets/rails_breadcrumbs.sass"
      end
    end
  end
end
