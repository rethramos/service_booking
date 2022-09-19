class Admin::BusinessesController < Admin::AdminController
  def index
    @businesses = Business.all
  end

  def show
  end
end
