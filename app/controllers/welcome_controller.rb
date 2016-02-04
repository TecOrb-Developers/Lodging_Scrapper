class WelcomeController < ApplicationController

  def index
	@tests = Scrape.all.order(id: "DESC").paginate(:page => params[:page], :per_page => 10)

  	# respond_to do |format|
	  #   format.html
	  #   format.csv do
	  #     headers['Content-Disposition'] = "attachment; filename=\"lodging.csv\""
	  #     headers['Content-Type'] ||= 'text/csv'
	  #   end
  	# end
  end

  def new
  	 ScrapWorker.perform_async
  	 redirect_to :back
  end

  def generate_csv
  	@data = Scrape.all
  	headers = ["link","name","rating","street_address","extended_address","city","state","pin","star","price","total_reviews","Traveller_rating","description","amenities","photos","reviews"] 

  	CSV.open('file.csv', 'w' ) do |writer|
		writer << headers
		@data.each do |record|
 			row = [record.link.strip,record.name.strip,record.rating.strip,record.s_address.strip,record.e_address.strip,record.city.strip,record.state.strip,record.pin.strip,record.star.strip,record.price.strip,record.total_reviews.strip,record.traveller_rating,record.description.strip,record.amenities,record.photos,record.reviews]
			writer <<  row
		end
	end
  end

end
