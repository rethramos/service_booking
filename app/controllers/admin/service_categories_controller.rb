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
    @service_category.image.attach(params[:service_category][:image])
    
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
    @service_category = ServiceCategory.find(params[:id])
    @business = @service_category.business
  end

  def update
    @service_category = ServiceCategory.find(params[:id])
    @business = @service_category.business

    if @service_category.update(service_category_params)
      flash[:success] = 'Successfully updated a service category.'
      redirect_to admin_business_url(@business)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service_category = ServiceCategory.find(params[:id])
    @service_category.destroy

    respond_to do |format|
      flash[:success] = "Service category was successfully destroyed."
      format.html { redirect_to admin_business_url(@service_category.business_id) }
      format.json { head :no_content }
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def service_category_params
    params.require(:service_category).permit(:name, :description, :image)
  end
end
