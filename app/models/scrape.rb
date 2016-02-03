class Scrape < ActiveRecord::Base
	validates :link, uniqueness: true
end
