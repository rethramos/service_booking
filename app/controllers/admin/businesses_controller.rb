class Admin::BusinessesController < Admin::AdminController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find params[:id]
    @service_categories = @business.service_categories
  end
end
