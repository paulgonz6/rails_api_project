require 'open-uri'
require 'json'

class ForecastsController < ApplicationController

  def location

    unless params[:address] == nil
      @the_address = params[:address]

      # CREATES URL TO CALL FOR ADDRESS SEARCH
      address_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@the_address}"
      address_url_safe = URI.encode(address_url)

      # PARSES DATA and FINDS LAT and LONG
      raw_data_address = open(address_url_safe).read
      parsed_data_address = JSON.parse(raw_data_address)

      the_latitude = parsed_data_address["results"][0]["geometry"]["location"]["lat"].to_f
      the_longitude = parsed_data_address["results"][0]["geometry"]["location"]["lng"].to_f

      # CREATES URL TO CALL FOR WEATHER SEARCH
      weather_url = "https://api.forecast.io/forecast/d62f0a592994b78850dff50ecac53d84/#{the_latitude},#{the_longitude}"
      weather_url_safe = URI.encode(weather_url)

      # PARSES RAW WEATHER DATA AND FINDS FORECASTS
      raw_data_weather = open(weather_url_safe).read
      parsed_data_weather = JSON.parse(raw_data_weather)

      @the_temperature = "#{parsed_data_weather["currently"]["temperature"]} degrees"
      @the_hour_outlook = parsed_data_weather["minutely"]["summary"]
      @the_day_outlook = parsed_data_weather["daily"]["data"][0]["summary"]
    end

  end

end
