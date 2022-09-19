class Admin::ServiceCategoriesController < Admin::AdminController
  def new
    @service_category = ServiceCategory.new
  end

  def create
    @service_category = ServiceCategory.new(service_category_params)
    if @service_category.valid?

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

  def service_category_params
    params.require(:service_category).permit(:name, :description)
  end
end
