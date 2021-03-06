class BlogCommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @blog_comment = BlogComment.new(blog_comment_params)
    @blog_comment.blog_id = @blog.id
    @blog_comment.user_id = current_user.id
    @user = @blog_comment.user
    if @blog_comment.save
      redirect_to blog_path(@blog)
    else
      render 'blogs/show'
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    blog_comment = @blog.blog_comments.find(params[:id])
    blog_comment.destroy
    redirect_to blog_path(params[:blog_id])

  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end
end