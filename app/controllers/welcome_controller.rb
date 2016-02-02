class WelcomeController < ApplicationController

  def index
		# respond_to do |format|
	 #    format.html
	 #    format.csv do
	 #      headers['Content-Disposition'] = "attachment; filename=\"lodging.csv\""
	 #      headers['Content-Type'] ||= 'text/csv'
	 #    end
  # 	end
  end

  def new

  	 ScrapWorker.perform_async
		# headers = ["name","rating","street address","extended_address","city","state","pin","star","price","total_reviews","Traveller_rating","description","amenities","photos","reviews"] 

  # 	CSV.open('file.csv', 'w' ) do |writer|
		# 	writer << headers
		# 	scrap_data.each do |record|
	 # 			row = [record["name"].chomp,record["rating"].chomp,record["street_address"].chomp,record["extended_address"].chomp,record["city"].chomp,record["state"].chomp,record["pin"].chomp,record["star_class"].chomp,record["price_range"].chomp,record["total_reviews"].chomp,record["traveller_rating"],record["description"].chomp,record["amenities"].map(&:chomp),record["photos"].map(&:chomp),record["reviews"] ] 
		# 		writer <<  row
		# 	end
		# end
  end

end
