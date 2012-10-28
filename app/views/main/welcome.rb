<% content_for :welcome do %>
	<section class="left_box">	
		<h5>Included Specs</h5>
		<%= form_for @item do %>		
			<% @specs.each do |spec| %>
				<p class="check_box"><%= check_box_tag :spec_ids, spec.id, @item.specs.include?(spec), :name => "item[spec_ids][]" %>
				<%= label_tag :spec_ids, spec.code %></p>
			<% end %>
			<%= hidden_field_tag "history", @history %>
			<%= hidden_field_tag "future", @future %>
			<%= submit_tag "Update Item" %>
		<% end %>
	</section>
<% end %>