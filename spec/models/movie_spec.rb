require "rails_helper"

RSpec.describe Movie, :type => :model do
    before(:all) do
        if Movie.where(:director => "Jackie Chan").empty?
          Movie.create(:title => "Vanguard", :director => "Jackie Chan",:rating => "PG", :release_date => "2020-09-30")
          Movie.create(:title => "The Foreigner", :director => "Jackie Chan",:rating => "PG", :release_date => "2017-10-13")
          Movie.create(:title => "The Scientist", :director => "Jackie Chan", :rating => "PG", :release_date => "2017-10-15")
        end
        
        if Movie.where(:title => "Anaconda").empty?
          Movie.create(:title => "Anaconda", :rating => "G", :release_date => "2001-01-01")
        end
        if Movie.where(:title => "Anaconda 2").empty?
            Movie.create(:title => "Anaconda 2",  :rating => "G", :release_date => "2005-11-01")
          end
    end

    describe "exist the same director" do
        it "returns the same director" do
          expect(Movie.similar_movies("Vanguard")).to eql(["Vanguard", "The Foreigner","The Scientist"])
          expect(Movie.similar_movies("Vanguard")).to_not include(["Anaconda"])
        end
    end

    describe "no exist director" do
        it "returns the sad path" do
          expect(Movie.similar_movies("Anaconda")).to eql(nil)
          expect(Movie.similar_movies("Anaconda 2")).to eql(nil)
        end
    end
end