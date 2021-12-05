module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_post, only: :create

      # POST /comments
      def create
        @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
