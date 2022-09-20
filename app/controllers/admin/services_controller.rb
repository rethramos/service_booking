class Admin::ServicesController < Admin::AdminController
  before_action :set_service, only: %i[ show edit update destroy ]
  before_action :set_business
  before_action :set_categories, only: [:new, :create, :edit, :update]
  around_action :set_time_zone, only: [:show]

  # GET /admin/businesses/1/services or /admin/businesses/1/services.json
  def index
    @services = @business.services
  end

  # GET /admin/businesses/1/services/1 or /admin/businesses/1/services/1.json
  def show
    @appointments = @service.appointments
  end

  # GET /admin/businesses/1/services/1/new
  def new
    @service = @business.services.build
  end

  # GET /services/1/edit
  def edit
  end

  # POST /admin/businesses/1/services/1/services or /admin/businesses/1/services/1/services.json
  def create
    @service = @business.services.build(service_params)

    respond_to do |format|
      if @service.save
        flash[:success] = "Service was successfully created."
        format.html { redirect_to admin_business_service_url(@business, @service) }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1 or /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        if service_params[:image].present?
          @service.image.attach(service_params[:image])
        end
        flash[:success] = "Service was successfully updated."
        format.html { redirect_to admin_business_service_url(@business, @service) }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/businesses/1/services/1 or /admin/businesses/1/services/1.json
  def destroy
    @service.destroy

    respond_to do |format|
      flash[:success] = "Service was successfully destroyed."
      format.html { redirect_to admin_business_services_url(@business) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    def set_business
      @business = Business.find(params[:business_id])  
    end

    def set_categories
      @categories = @business.service_categories.map {|c| [c.name, c.id]}
    end

    def set_time_zone
      Time.use_zone(@business.timezone) { yield }
    end
  
    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(
        :business_id,
        :service_category_id,
        :name,
        :description,
        :unit_price,
        :image
      )
    end
end
