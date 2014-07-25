module RailsBreadcrumbs
  module ControllerAdditions
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
    end

    module ClassMethods
      def add_breadcrumb(name, url, options = {})
        options = ::RailsBreadcrumbs.options.merge(options)
        before_filter options do |controller|
          controller.send(:add_breadcrumb, localization(name, options), url)
        end
      end
    end

    def add_breadcrumb_with_parent(object, path, options={})
      return unless object.present?
      options = ::RailsBreadcrumbs.options.merge(options)
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
        name = localization(segment, options, names)
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
        name = localization(segment, options, names)
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
      def add_breadcrumb(name, url = '')
        @breadcrumbs ||= []
        url = eval(url.to_s) if url =~ /_path|_url|@/
        @breadcrumbs << [name, url]
      end

      def make_url_and_add_breadcrumb(object, path, options)
        name = options[:name].present? ? options[:name] : "name"
        url = make_url_for(object, path, options)
        send(:add_breadcrumb, object[name], url)
      end

      def make_url_for(object, path, options)
        target = options[:target].present? ? options[:target] : object.class.name.underscore
        url = path.to_s + "(#{target}: '#{object.slug}'"
        options[:url_options].each_pair do |key, value|
          url += ", #{key}: '#{value}'"
        end
        url += ")"
        url
      end

      def localization(name, options, names={})
        name = name.to_s.underscore
        default_name = name.sub('_', ' ').camelcase
        default_name = names[name] if names.has_key?(name)
        I18n.t options[:locale_root] + name, default: default_name
      end
  end
end
