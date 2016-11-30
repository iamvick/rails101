class PostsController < ApplicationController
    before_filter :authenticate_user!, :only => [:new, :create]
    before_filter :find_group_post_and_check_permission, :only => [:edit,:update,:destroy]
    def new
        @group = Group.find(params[:group_id])
        @post = Post.new
    end
    def create
        @group = Group.find(params[:group_id])
        @post = Post.new(post_params)
        @post.group = @group
        @post.user = current_user
        if @post.save
            redirect_to group_path(@group)
        else
            render :new
        end
    end
    def edit
    end
    def update
        if @post.update(post_params)
            redirect_to account_posts_path(@current_user),notice:"Update Success"
        else
            render :edit
        end
    end
    def destroy
        @post.destroy
        flash[:alert] = "Post deleted"
        redirect_to account_posts_path(@current_user)
    end
    private
    def find_group_post_and_check_permission
        @group = Group.find(params[:group_id])
        if current_user != @group.user
            redirect_to root_path,alert:"You have no permission."
        end
        @post = current_user.posts.find(params[:id])
    end
    def post_params
        params.require(:post).permit(:content)
    end
end
