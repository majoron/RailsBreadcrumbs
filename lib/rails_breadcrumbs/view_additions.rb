#
module RailsBreadcrumbs
  module ViewAdditions
    # ::Rails.logger.error("...")

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
      options = ::RailsBreadcrumbs.options.merge(options)

      # First item is home
      if options[:include_home_icon]
        output << content_tag(:li, {:class => "first_breadcrumb_item"}, false) do
          link_to(image_tag("breadcrumbs/home.png", {:alt => "Home", :title => "Home"}),options[:home_path]) +
          (@breadcrumbs && @breadcrumbs.size() > 0 ? raw(options[:item_separator]) : "")
        end
      end

      # First item is home
      if options[:include_home_label]
        output << content_tag(:li, {:class => "first_breadcrumb_item"}, false) do
          link_to( h(options[:home_label]), options[:home_path]) +
          (@breadcrumbs && @breadcrumbs.size() > 0 ? raw(options[:item_separator]) : "")
        end
      end

      # Midle items
      if @breadcrumbs
        @breadcrumbs[0..-2].each do |txt, path|
          output << content_tag(:li, {:class => "last_breadcrumb_item"}, false) do
            link_to( h(txt), path) + raw(options[:item_separator])
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