module RailsBreadcrumbs
  module ControllerAdditions
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
    end

    module ClassMethods
      def add_breadcrumb(name, url, options = {})
        before_filter options do |controller|
          controller.send(:add_breadcrumb, name, url)
        end
      end
    end

    def add_breadcrumb_with_parent(object, path, options={})
      return unless object.present?
      if defined?(Ancestry) && Ancestry::InstanceMethods.instance_methods.include?(:path)
        object.path.each do |element|
          make_url_and_add_breadcrumb(element, path, options)
        end
      elsif object.parent.present?
        [object.parent, object].each do |element|
          make_url_and_add_breadcrumb(element, path, options)
        end
      else
        make_url_and_add_breadcrumb(object, path, options)
      end
    end

    def add_breadcrumbs_by_path(names = {}, options = {})
      options = ::RailsBreadcrumbs.options.merge(options)
      path_parts = controller_path.split('/')
      path_parts.each do |segment|
        link_name = segment.sub('_', ' ').camelcase
        link_name = names[segment] if names.has_key?(segment)
        name = I18n.t options[:locale_root] + segment, :default => link_name
        if segment != path_parts.last
          route = nil
          path_parts.each do |temp|
            route = (route.nil? ? temp: route +'_'+ temp)
            break if temp == segment
          end
          link = send(route + '_path')
        else
          link = request.path
        end
        add_breadcrumb(name, link)
      end
    end

    def add_breadcrumbs_with_action_by_path(names = {}, options = {})
      options = ::RailsBreadcrumbs.options.merge(options)
      path_parts = controller_path.split('/') << action_name
      path_parts.each do |segment|
        link_name = segment.sub('_', ' ').camelcase
        link_name = names[segment] if names.has_key?(segment)
        name = I18n.t options[:locale_root] + segment, :default => link_name
        if segment != path_parts.last
          route = nil
          path_parts.each do |temp|
            route = (route.nil? ? temp: route +'_'+ temp)
            break if temp == segment
          end
          link = send(route + '_path')
        else
          link = request.path
        end
        add_breadcrumb(name, link)
      end
    end

    private
      # Add breadcrumb for page
      def add_breadcrumb name, url = ''
        @breadcrumbs ||= []
        url = eval(url.to_s) if url =~ /_path|_url|@/
        @breadcrumbs << [name, url]
      end

      def make_url_and_add_breadcrumb(object, path, options)
        url_option = options[:url_option].present? ? options[:url_option] : object.class.name.underscore
        name = options[:name].present? ? options[:name] : "name"
        url = path.to_s + "(#{url_option}: '#{object.slug}')"
        send(:add_breadcrumb, object[name], url)
      end
  end
end
