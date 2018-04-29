class FavoritesController < ApplicationController

  def index
    @favorite_posts = current_user.favorite_posts
  end

  def create 
    favorite = current_user.favorites.create(post_id: params[:post_id])
	redirect_to posts_url, notice: "#{favorite.post.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id]).destroy
	redirect_to post_url, notice: "#{favorite.post.user.name}さんの投稿をお気に入り解除しました"
  end

end
