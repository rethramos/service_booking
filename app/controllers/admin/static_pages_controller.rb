class Admin::StaticPagesController < Admin::AdminController
  def home
    @users = User.where admin: false
    @user_count = @users.count
  end
end
