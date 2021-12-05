module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: :show

      # GET /posts/1
      def show
        options = {}
        options[:include] = [:comments]
        render json: PostSerializer.new(@post, options).serializable_hash.to_json
      end

      # POST /posts
      def create
        @post = Post.new(post_params.merge(user_id: current_user.id))

        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:name, :title, :content)
      end
    end
  end
end
