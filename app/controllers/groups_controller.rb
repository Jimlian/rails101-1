class GroupsController < ApplicationController
 before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]

def index
  @groups = Group.all
end

def new
  @group = Group.new
end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
end

def edit
  @group = Group.find(params[:id])

  if current_user != @group.user
    redirect_to root_path, alert: "You have no permission"
  end
end

def create
  @group = Group.new(group_params)
  @group.user = current_user
  if @group.save
       redirect_to groups_path
     else
       render :new
     end
  end

def update
  @group = Group.find(params[:id])

  @group.update(group_params)

redirect_to groups_path, notice: "Update Success"
end

def destroy
  @group = Group.find(params[:id])
  @gourp.destroy
  flash[:alert] = "Group Deleted"
  redirect_to groups_path
end

  private

  def group_params
    params.require(:group).permit(:title, :description)
end

end
