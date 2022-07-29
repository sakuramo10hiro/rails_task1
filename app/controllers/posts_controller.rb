class PostsController < ApplicationController
  def index
    @posts = Post.all 
    @post_count = Post.all.count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :start, :finish, :allday, :memo))
    if @post.save
     flash[:notice] = "スケユールを新規登録しました"
     redirect_to :posts
    else
     render"new",status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :start, :finish, :allday, :memo))
      flash[:notice] = "スケジュールを更新しました"
      redirect_to :posts
    else
      render "edit",status: :see_other
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to :posts,status: :see_other
  end
end

#Turboを使っている場合、バリデーション失敗時のレスポンスに必ず status: :unprocessable_entity を付ける必要があります。これがないとバリデーション失敗時のエラーメッセージが表示されません。