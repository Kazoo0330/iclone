class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :must_login, only: [:new, :edit, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
	@user = User.find_by(id: @post.user_id)
	@favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
	@post.user_id = current_user.id

	@post.save!

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿ができました' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image,:image_cache, :title, :content, :user_id, :post_id)
    end

	def must_login
	  unless !current_user.nil?
	    redirect_to posts_path, notice: "ログインしてください"
	  end
	end


end
