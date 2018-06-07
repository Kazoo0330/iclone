class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :must_login, only: %i[new edit show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
	@user = User.find_by(id: @post.user_id)
	@favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
	else
	  @post = Post.new
	end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
	@post.user_id = current_user.id

	if @post.save
	  PostMailer.post_mail(@post).deliver
	  redirect_to post_path(@post.id)
	else
	  render 'new'
	end 
  end

#    respond_to do |format|
#      if @post.save
# 	    PostMailer.post_mail(@post).deliver
#        format.html { redirect_to @post, notice: '投稿ができました' }
    ##    format.json { render :show, status: :created, location: @post }
#      else
#        format.html { render :new_post }
     ##   format.json { render json: @post.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿の変更ができました。' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿の削除ができました。' }
      format.json { head :no_content }
    end
  end

  def ensure_current_user
    @post = Post.find_by(id:params[:id])
	  if @post.user_id != @current_user.id
	    flash[:notice] = "できませんでした"
		redirect_to("/posts/index")
	  end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.requir(:post).permit %i[image image_cache title content user_id post_id]
  end

  def must_login
	unless !current_user.nil?
	  redirect_to posts_path, notice: "ログインしてください"
	end
  end
end
