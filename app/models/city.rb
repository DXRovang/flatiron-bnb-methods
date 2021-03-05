class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  
  def city_openings(date1, date2)
    self.listings.select do |listing|
      listing.reservations.all? do |r|
        r.checkout.strftime("%F") < date1 || r.checkin.strftime("%F") > date2  
      end
    end
  end

  def self.highest_ratio_res_to_listings
    @highest_ratio = 0
    City.all.each do |city|
      @number_of_listings = city.listings.count #finished
      @reservations = 0
      city.listings.each do |listing|
        @reservations += listing.reservations.count #finished
      end
      @ratio = @reservations / @number_of_listings
      if @ratio > @highest_ratio
        @highest_ratio = @ratio
        @city = city
      end
    end
    @city
  end

  def self.most_res
    @highest_number = 0
    City.all.each do |city|
      city.listings.each do |listing|
        if listing.reservations.count > @highest_number
          @highest_number = listing.reservations.count
          @city = city
        end
      end
    end
    @city
  end

end

