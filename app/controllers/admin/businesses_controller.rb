class Admin::BusinessesController < Admin::AdminController
  def new
    @business = current_user.businesses.build
    @business.build_address
  end

  def create
    @business = current_user.businesses.build(business_params)
    if @business.save
      redirect_to admin_businesses_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find params[:id]
    @service_categories = @business.service_categories
    @services = @business.services
  end

  private

  def business_params
    params.require(:business).permit(
      :name,
      :timezone,
      address_attributes: %i[line_one line_two city province country postal_code]
    )
  end
end
