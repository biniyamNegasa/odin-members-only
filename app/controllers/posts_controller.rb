class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end


  # GET /posts/new
  def new
    @post = Post.new
  end


  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
