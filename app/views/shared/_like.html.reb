<% if micropost.liked?(current_user) %>
  <%= link_to "いいね解除", micropost_likes_path(micropost.id), method: :delete %>
<% else %>
  <%= link_to "いいね", micropost_likes_path(micropost.id), method: :post %>
<% end %>
<P><%= micopost.likes.count %></P>
