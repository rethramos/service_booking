class Admin::SessionsController < Admin::AdminController
  skip_before_action :ensure_logged_in, only: %i[new create]
  skip_before_action :ensure_admin, only: %i[new create]

  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password]) && @user.admin?
      log_in @user
      redirect_to admin_root_url
    else
      flash.now[:danger] = 'Invalid credentials.'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to admin_login_url
  end
end
