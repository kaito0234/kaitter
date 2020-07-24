<% if micropost.liked?(current_user) %>
  <%= link_to "いいね解除", micropost_likes_path(micropost.id), method: :delete, remote: true %>
<% else %>
  <%= link_to "いいね", micropost_likes_path(micropost.id), method: :post, remote:true %>
<% end %>
<P><%= micopost.likes.count %></P>
