class Admin::ServiceCategoriesController < Admin::AdminController
  def new
    set_business
    @service_category = @business.service_categories.build
  end

  def create
    set_business
    @service_category = @business.service_categories.build(
      service_category_params
    )
    
    if @service_category.save
      flash[:success] = 'Successfully created a service category.'
      redirect_to admin_business_url(@business)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def service_category_params
    params.require(:service_category).permit(:name, :description)
  end
end
