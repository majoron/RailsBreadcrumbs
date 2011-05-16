# RailsBreadcrumbs
module RailsBreadcrumbs
  # ::Rails.logger.error("...")

  module ViewAdditions
    # default options that can be overridden on the global level
    @@breadcrumbs_options = {
      :home_controller          => 'welcome',                 #
      :home_action              => 'index',                   #
      :item_separator           => '&gt;',                    #
      :css_class                => 'breadcrumbs',             #
      :fist_item_css_class      => 'first_breadcrumb_item',   #
      :last_item_css_class      => 'last_breadcrumb_item',    #
      :make_last_item_as_link   => true,                      #
      :include_home_icon        => true,                      #
    }
    mattr_reader :breadcrumbs_options

    #
    # Renders breadcrumbs
    #
    #     <ul>
    #       <li class="first">
    #         <%=link_to(image_tag("breadcrumbs/home.png", {:alt => "Home", :title => "Home"}), :controller => "/welcome") %> &gt;
    #       </li>
    #       <% if @breadcrumbs %>
    #         <% @breadcrumbs[0..-2].each do |txt, path| %>
    #           <li>
    #             <%= link_to(h(txt), path) %> &gt;
    #           </li>
    #         <% end %>
    #         <li>
    #           <span><%= link_to(h(@breadcrumbs.last.first), @breadcrumbs.last.second) %> </span>
    #         </li>
    #       <% end %>
    #     </ul>
    #
    def render_breadcrumbs(options = {})
      output = ""
      options = @@breadcrumbs_options.merge(options)

      # First item is home
      if options[:include_home_icon]
        output << content_tag(:li, {:class => "first_breadcrumb_item"}, false) do
          link_to(image_tag("breadcrumbs/home.png", {:alt => "Home", :title => "Home"}) + raw(options[:item_separator]),
            :controller => options[:home_controller], :action => options[:home_controller])
        end
      end

      # Midle items
      if @breadcrumbs
        @breadcrumbs[0..-2].each do |txt, path|
          output << content_tag(:li, {:class => "last_breadcrumb_item"}, false) do
            link_to( h(@breadcrumbs.last.first) + raw(options[:item_separator]), @breadcrumbs.last.second)
          end
        end
      end

      # Last item
      if @breadcrumbs
        if options[:make_last_item_as_link]
          output << content_tag(:li, {:class => "last_breadcrumb_item"}, false) do
            link_to( h(@breadcrumbs.last.first), @breadcrumbs.last.second)
          end
        else
          output << content_tag(:li, {:class => "last_breadcrumb_item"}, false) do
            content_tag(:span, h(@breadcrumbs.last.first))
          end
        end
      end

      # Return result
      content_tag('ul', output, {:class => options[:css_class]}, false)
    end
  end
end