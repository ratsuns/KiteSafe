class MapController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @spots = Spot.all
    @markers = @spots.map do |spot|
      {
        lng: spot.longitude,
        lat: spot.latitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { spot: spot }),
        description: spot.description,
        spot_id: spot.id,
        spot_type: spot.spot_type,
        name: spot.name,
        reviews: spot.reviews
      }
    end
  end
end
