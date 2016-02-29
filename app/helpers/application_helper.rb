module ApplicationHelper
  require 'rubygems'
	require 'nokogiri'
	require 'open-uri'
	require 'json'
	require 'csv'


	def get_urls
		CSV.open('tripadvisor.csv', 'r' ) do |writer|
	  	@links=[]
	  	@first = 0
	  	writer.each do |row|
	  		@links << row[0] 
	  		@first+=1
	  	end
		end
		@links
	end

	def invalid_img_urls
		urls = ["pencil.png","maps.google.com","no_user_photo-v1.gif","rev_06.png","lvl_06.png","diamond-debutante.jpg","Visitor.png","Appreciated.png","gray_flag.png",".gif"]
	end

	def invalid_urls
		urls = InvalidUrl.all.pluck(:url)#["link","http://www.tripadvisor.com/Hotel_Review-g38803-d272915-Reviews-The_Northrup_House-Iola_Kansas.html","https://www.tripadvisor.in/Hotels-g38803-Iola_Kansas-Hotels.html","http://www.tripadvisor.com/Hotel_Review-g32032-d73309-Reviews-The_Red_Raven_Inn-Yellville_Arkansas.html","http://www.tripadvisor.com/Hotel_Review-g54046-d270519-Reviews-Budget_Host_Spirit_of_76_Motel-York_Pennsylvania.html","http://www.tripadvisor.com/Hotel_Review-g56926-d1646454-Reviews-White_Top_Motel-Yorktown_Texas.html"]
	end

	def completed_urls
		urls = Scrape.all.pluck(:link)
	end

	def scrap_data
		urls = get_urls
		@all_records = []
		@invalid_images = invalid_img_urls
		@invalid_urls = invalid_urls
		@completed_urls = completed_urls
		@c=0
		urls -= @invalid_urls
		urls -= @completed_urls
		urls.each do |url|
			lodging={}
			p "--------------#{url}"
			begin
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
			lodging["rating"] = doc.at_css('.rating_rr .rating_rr_fill').present? ? doc.at_css('.rating_rr .rating_rr_fill')["content"] : "n/a"
			lodging["total_reviews"]= doc.at_css('.more').present? ? doc.at_css('.more').text.split(" ")[0] : "n/a"
			lodging["rooms"]  = doc.at_css(".tabs_num_rooms").present? ? doc.at_css(".tabs_num_rooms").text : "n/a"
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
			@images_url =[]
			@images_name=[]
			@photos.first(5).each do |f|
			 if !@invalid_images.any? {|ele| f.include?(ele) }
			 	open("scraped_images/#{lodging["name"].parameterize("_")}-#{f.split('/').last}", 'wb') do |file|
				  file << open(f).read
				end
			 		@images_url << f
			 		@images_name << "#{lodging["name"].parameterize("_")}-#{f.split('/').last}"
			 end
			end
			lodging["photos"] = @images_url
			lodging["photos_name"]= @images_name
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

			@data = Scrape.create(name: lodging["name"].strip,link: lodging["link"],rating: lodging["rating"],s_address: lodging["street_address"],e_address: lodging["extended_address"],city: lodging["city"],state: lodging["state"],pin: lodging["pin"],star: lodging["star_class"],price: lodging["price_range"].present? ? lodging["price_range"].strip : lodging["price_range"],rooms: lodging["rooms"] ,total_reviews: lodging["total_reviews"],traveller_rating: lodging["traveller_rating"],description: lodging["description"],amenities: lodging["amenities"],photos_name: lodging["photos_name"],photos: lodging["photos"],reviews: lodging["reviews"])
			if @data.id != nil
				@all_records << lodging 
				p "----------------#{@c+=1}-------------db id #{@data.id}-----"
			else
				p "++++XXXXXXX++++++Dublicate is not saving++++XXXXXXXX"
			end
			rescue => e
				if !InvalidUrl.exists?(:url=>url)
					iu=InvalidUrl.create(:url=>url)
					p "xxxxxxx #{e.backtrace} xxx Exception in xxxxx  #{iu.url} "
				end
			end
			sleep [1,2,3].sample
		end
		@all_records
	end

	def update_data
		urls = Scrape.where("rooms = ?","").pluck(:link)
		urls.each do |url|
			lodging={}
			@data = Scrape.find_by_link(url)
			begin
				doc = Nokogiri::HTML(open(url))
				rooms  = doc.at_css(".tabs_num_rooms").text
				 
				if @data.update_attributes!(:rooms=>rooms)
					p "--#{@data.id}-------rooms = #{rooms}"
				else
					p "xxx--------not updated------------#{@data.id}"
				end
			rescue
				p "XXXXXXXXX Exception XXXXXX #{url}"
			end
		end
	end
end
