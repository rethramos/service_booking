class Admin::BusinessesController < Admin::AdminController
  before_action :transform_location, only: %i[create update]

  def new
    @business = current_user.businesses.build
    @business.build_address
  end

  def create
    @business = current_user.businesses.build(business_params)
    if @business.save
      flash[:success] = 'Business was successfully created.'
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
    @business.build_address if @business.address.nil?
  end

  def update
    @business = Business.find params[:id]
    if @business.update(business_params)
      flash[:success] = 'Business was successfully updated.'
      redirect_to admin_business_path(@business)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.common_name || country.iso_short_name
  end

  def get_state_name(state_code, country_code)
    CS.states(country_code)[state_code] || ''
  end

  def transform_location
    prev_country =  params[:business][:address_attributes][:country]&.to_sym || ''
    prev_province = params[:business][:address_attributes][:province]&.to_sym || ''
    params[:business][:address_attributes][:country] = CS.countries[prev_country]
    params[:business][:address_attributes][:province] = get_state_name(prev_province, prev_country)
  end

  def business_params
    params.require(:business).permit(
      :name,
      :timezone,
      address_attributes: %i[line_one line_two city province country postal_code]
    )
  end
end
