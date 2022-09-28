class Admin::BusinessesController < Admin::AdminController
  def new
    @business = current_user.businesses.build
    @business.build_address
  end
  
  def create
    @business = current_user.businesses.build(business_params)
    if @business.save
      flash[:success] = "Business was successfully created."
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
  
  def edit
    @business = Business.find params[:id]
  end
  
  def update
    @business = Business.find params[:id]
    if @business.update(business_params)
      flash[:success] = "Business was successfully updated."
      redirect_to admin_business_path(@business)
    else
      render :edit, status: :unprocessable_entity
    end
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
