class Admin::BusinessesController < Admin::AdminController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find params[:id]
  end
end
