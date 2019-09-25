require "building_rocksolid/version"

require 'http'

class Building
  attr_accessor :name, :address, :height, :construction_date, :architect, :id
  def initialize(input_options)
    # add attributes here as instance variables
    @name = input_options["name"]
    @address = input_options["address"] 
    @height = input_options["height"]
    @construction_date = input_options["construction_date"]
    @architect = input_options["architect"]
    @id = input_options["id"]
  end

  def self.all
    response = HTTP.get("http://localhost:3000/api/buildings")
    buildings_details = response.parse
    buildings_details.each do |building_detail|
      Building.find(building_detail["id"])
    end
  end

  def self.create(building_details)
    response = HTTP.post("http://localhost:3000/api/buildings", form: building_details)
    building_details = response.parse
    Building.new(building_details)
  end

  def self.find(input_id)
    # write your logic for the method here
    response = HTTP.get("http://localhost:3000/api/buildings/#{input_id}")
    building_details = response.parse
    Building.new(building_details)
  end

  def update(client_params)
    response = HTTP.patch(
                          "http://localhost:3000/api/buildings/#{id}", 
                          form: client_params
                          )

  end

  def self.destroy(building_id)
    response = HTTP.delete("http://localhost:3000/api/buildings/#{building_id}")
  end
end