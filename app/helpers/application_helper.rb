module ApplicationHelper
  require 'rubygems'
	require 'nokogiri'
	require 'open-uri'
	require 'json'
	require 'csv'


	def get_urls
		urls = ["http://www.tripadvisor.com/Hotel_Review-g43666-d506106-Reviews-Barteau_House-Zumbrota_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43666-d95412-Reviews-Americas_Best_Value_Inn_Zumbrota-Zumbrota_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43230-d267935-Reviews-Willows_on_the_River-Lake_City_Minnesota.html"]#,"http://www.tripadvisor.com/Hotel_Review-g43230-d1013281-Reviews-John_Hall_s_Alaskan_Lodge-Lake_City_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43466-d1466518-Reviews-Hampton_Inn_Suites_Rochester_North-Rochester_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43466-d227677-Reviews-Comfort_Inn_Rochester-Rochester_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43665-d561185-Reviews-Burr_Oaks_B_B-Zumbro_Falls_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g43230-d268394-Reviews-AmericInn_Lodge_Suites_Lake_City-Lake_City_Minnesota.html","http://www.tripadvisor.com/Hotel_Review-g143057-d122845-Reviews-Zion_Lodge-Zion_National_Park_Utah.html","http://www.tripadvisor.com/Hotel_Review-g143057-d1803805-Reviews-The_Center_for_True_North-Zion_National_Park_Utah.html"]#,"http://www.tripadvisor.com/Hotel_Review-g61001-d226531-Reviews-Quality_Inn_at_Zion_Park-Springdale_Utah.html","http://www.tripadvisor.com/Hotel_Review-g61001-d99965-Reviews-Flanigan_s_Inn-Springdale_Utah.html","http://www.tripadvisor.com/Hotel_Review-g61001-d99963-Reviews-Cliffrose_Lodge_Gardens-Springdale_Utah.html","http://www.tripadvisor.com/Hotel_Review-g61001-d226532-Reviews-Canyon_Ranch_Motel-Springdale_Utah.html","http://www.tripadvisor.com/Hotel_Review-g61001-d1130977-Reviews-Cable_Mountain_Lodge-Springdale_Utah.html"]#,"http://www.tripadvisor.com/Hotel_Review-g57778-d126039-Reviews-Shenandoah_Crossing-Gordonsville_Virginia.html","http://www.tripadvisor.com/Hotel_Review-g2101211-d673344-Reviews-BEST_WESTERN_PLUS_Crossroads_Inn_Suites-Zion_Crossroads_Virginia.html","http://www.tripadvisor.com/Hotel_Review-g58841-d110945-Reviews-Vintage_Valley_Inn-Zillah_Washington.html","http://www.tripadvisor.com/Hotel_Review-g58773-d672614-Reviews-Travel_Inn-Sunnyside_Washington.html","http://www.tripadvisor.com/Hotel_Review-g58773-d456329-Reviews-Rodeway_Inn_Sunnyside-Sunnyside_Washington.html","http://www.tripadvisor.com/Hotel_Review-g58786-d665497-Reviews-Quality_Inn_Suites-Toppenish_Washington.html"]
	end

	def invalid_img_urls
		urls = ["pencil.png","maps.google.com","no_user_photo-v1.gif","rev_06.png","lvl_06.png","diamond-debutante.jpg","Visitor.png","Appreciated.png","gray_flag.png"]
	end

	def scrap_data
		urls = get_urls
		@all_records = []
		@invalid_images = invalid_img_urls
		@c=0

		urls.each do |url|
			lodging={}
			doc = Nokogiri::HTML(open(url))
			lodging["link"]=url
			lodging["name"]  = doc.at_css("#HEADING").text
			lodging["street_address"] = doc.at_css("#HEADING_GROUP .street-address").present? ? doc.at_css("#HEADING_GROUP .street-address").text : "n/a"
			lodging["extended_address"] = doc.at_css("#HEADING_GROUP .extended-address").present? ? doc.at_css("#HEADING_GROUP .extended-address").text : "n/a"
			lodging["city"]  = doc.at_css('.locality span:nth-child(1)').present? ? doc.at_css('.locality span:nth-child(1)').text : "n/a"
			lodging["state"]  = doc.at_css('.locality span:nth-child(2)').present? ? doc.at_css('.locality span:nth-child(2)').text : "n/a"
			lodging["pin"]  = doc.at_css('.locality span:nth-child(3)').present? ?  doc.at_css('.locality span:nth-child(3)').text : "n/a"
			lodging["star_class"]  = doc.at_css('.stars').present? ? doc.at_css('.stars').text.split('star')[0] : "n/a"
			lodging["price_range"]  = doc.at_css('.address :nth-child(3) span').present? ? doc.at_css('.address :nth-child(3) span').text : "n/a"
			lodging["description"]  = doc.at_css('.tabs_descriptive_text').present? ? doc.at_css('.tabs_descriptive_text').text : "n/a"
			lodging["rating"] = doc.at_css('.rating_rr .rating_rr_fill')["content"]
			lodging["total_reviews"]= doc.at_css('.more').present? ? doc.at_css('.more').text.split(" ")[0] : "n/a"
			
			@traveller_rating=[]
			@cat_count=0
			doc.css('.row_fill').each do |w|
				@cat_count+=1
				if @cat_count==1
					@cate = "Excellent"
				elsif @cat_count==2
					@cate = "Very good"
				elsif @cat_count==3
					@cate = "Average"
				elsif @cat_count==4
					@cate = "Poor"
				elsif @cat_count==5
					@cate = "Terrible"
				end
				@category =  w["style"].split(":")[1].split("%")[0]
				
				@traveller_rating << "#{@cate}:#{((lodging["total_reviews"].to_f)*(@category.to_f)/100).round}"
			end
			lodging["traveller_rating"]=@traveller_rating
			
			@photos = []
			@js = doc.search("[text()*='lazyImgs']").text.split('lazyImgs = [')[1].split("];")[0]

			parsed_json = ActiveSupport::JSON.decode("["+@js+"]")

			parsed_json.each do |p|
				@photos<< p["data"] 
			end
			@photos.slice!(0)
			@images =[]
			@photos.first(5).each do |f|
			 if !@invalid_images.any? {|ele| f.include?(ele) }
			 	open("#{f.split('/').last}", 'wb') do |file|
				  file << open(f).read
				end
			 		@images << f
			 end
			end
			lodging["photos"] = @images
			@amenities = []
			doc.css(".property_tags li").each do |item|
				@amenities << item.text.gsub("\n","")
			end
			lodging["amenities"] = @amenities

			# =============================reviews=================================
			@users=[]
			doc.css('.mo').each do |u|
				@users << u.text.gsub("\n","")
			end
			@titles=[]
			doc.css('.noQuotes').each do |t|
				@titles << t.text
			end

			@description=[]
			doc.css('.partial_entry').each do |r|
				@description << r.text.first(200).gsub("\n","")
			end
			@review_rating=[]
			doc.css('#REVIEWS .rating_s').each do |rr|
				@review_rating << rr.at_css('.rating_s_fill')["alt"]
			end
			@rating_date=[]
			doc.css('.ratingDate').each do |rd|
				@rating_date << rd.text.gsub("\n","")
			end
			@locations = []
			doc.css('#REVIEWS .location').each do |l|
				@locations << l.text.gsub("\n","")
			end

			@user_reviews=[]
			for i in 0..@users.count
				rev={}
				rev["by"]= @users[i]
				rev["rate"]=	@review_rating[i]
				rev["location"]= @locations[i]
				rev["title"] = @titles[i]
				rev["date"] = @rating_date[i]
				rev["description"] = @description[i]
				@user_reviews << rev
			end
			lodging["reviews"] = @user_reviews

			@all_records << lodging 
			p "----------------#{@c+=1}"
		end
		@all_records
	end
end
