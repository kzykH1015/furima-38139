class CommentsController < ApplicationController
  def show
    @comments = @item.comments.includes(:user)
    @Comment = Comment.new
  end
end
