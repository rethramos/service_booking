class LocationsController < ApplicationController
  def countries
    render json: CS.countries
  end

  def states
    res = CS.states(params[:country_code]).map do |k,v|
      { code: k, name: v }
    end
    render json: res
  end

  def cities
    res = CS.cities(params[:state_code], params[:country_code])

    if res.nil?
      render json: {}
    else
      res = res.map do |city|
        { name: city }
      end
      render json: res
    end
  end
end
