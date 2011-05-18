#
module RailsBreadcrumbs
  module ControllerAdditions
    # ::Rails.logger.error("...")

    # default options that can be overridden on the global level
    @@breadcrumbs_options = {
      :locale_root       => 'navigation.breadcrumbs.',  #
    }
    mattr_reader :breadcrumbs_options

    #
    def self.add_breadcrumb(name, url, options = {})
      before_filter options do |controller|
        controller.send(:add_breadcrumb, name, url)
      end
    end

    # Add breadcrumb for page
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      url = eval(url) if url =~ /_path|_url|@/
      @breadcrumbs << [name, url]
    end

    #
    def add_breadcrumbs_by_path(names = {}, options = {})
      options = @@breadcrumbs_options.merge(options)
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

    #
    def add_breadcrumbs_with_action_by_path(names = {}, options = {})
      options = @@breadcrumbs_options.merge(options)
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
  end
end