# Include gems
require "rubygems"

# CaptchaValidateable
module RailsBreadcrumbs
  # RAILS_DEFAULT_LOGGER.error("...")

  protected
  def add_breadcrumbs_by_path(names = {})
    path_parts = controller_path.split('/')
    path_parts.each do |segment|
      link_name = segment.sub('_', ' ').camelcase
      link_name = names[segment] if names.has_key?(segment)
      name = I18n.t "navigation.breadcrumbs.#{segment}", :default => link_name
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

  # Add breadcrumb for page
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end

  def self.included(target)
    target.extend(ClassMethods)
  end

  module ClassMethods
    def get_random_string (len = 10)
      result = ""
      len.times do
        result << CaptchaValidateable.random_chars[rand(CaptchaValidateable.random_chars.size)]
      end
      result
    end

    def get_captcha_key (len = 5)
      result = ""
      len.times do
        result << CaptchaValidateable.random_chars[rand(CaptchaValidateable.random_chars.size)]
      end
      result
    end
  end
end
