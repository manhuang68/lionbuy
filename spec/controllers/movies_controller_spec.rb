require "rails_helper"

RSpec.describe MoviesController, :type => :controller do
    before(:all) do
        if Movie.where(:director => "Jackie Chans").empty?
          Movie.create(:title => "Vanguards", :director => "Jackie Chans", :rating => "PG", :release_date => "2020-09-30")
          Movie.create(:title => "The Foreigners", :director => "Jackie Chans", :rating => "PG", :release_date => "2017-10-13")
          Movie.create(:title => "The Scientist", :director => "Jackie Chans", :rating => "PG", :release_date => "2017-10-15")
        end
        
        if Movie.where(:title => "Anacondas").empty?
          Movie.create(:title => "Anacondas",  :rating => "G", :release_date => "2001-01-01")
        end
        if Movie.where(:title => "Anaconda 2").empty?
            Movie.create(:title => "Anaconda 2", :rating => "G", :release_date => "2005-11-01")
          end
    end

    describe "existing the same director" do
        it "returns the same director" do
          expect(Movie.similar_movies("Vanguards")).to eql(["Vanguards", "The Foreigners", "The Scientist"])
          expect(Movie.similar_movies("Vanguards")).to_not include(["Anacondas"])
        end
    end

       describe "creating new movie" do
        it "movies with valid parameters" do
          get :create, {:movie => {:title => "Vanguardia", :director => "Jackie Chans",:rating => "PG", :release_date => "2020-09-30"}}
          expect(response).to redirect_to movies_path
          expect(flash[:notice]).to match(/Vanguardia was successfully created./)
          Movie.find_by(:title => "Vanguardia").destroy
        end
      end
      
      describe "updating variables" do
        it "checking movies " do
          movie = Movie.create(:title => "Police", :director => "Chenglong", :rating => "PG-13", :release_date => "2005-12-01")
          get :update, {:id => movie.id, :movie =>{:country => "China", :length => "125 minutes"} }
          expect(response).to redirect_to movie_path(movie)
          expect(flash[:notice]).to match(/Police was successfully updated./)
          movie.destroy
        end
      end


end