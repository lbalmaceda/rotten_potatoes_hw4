require 'spec_helper'

describe MoviesController do
	describe 'searching for similar movies by director' do
		
		it 'accept search by non-nil/non-empty director' do
			m1 = FactoryGirl.create(:movie, :director => 'Patrick')
			Movie.should_receive(:similar_movies_by_director)
				.with('Patrick')

			get :similar, {:id => m1.id}
			response.should_not redirect_to(:root)
		end

		it 'redirect home if movie has empty director' do
			m1 = FactoryGirl.create(:movie, :director => '')
			Movie.should_receive(:similar_movies_by_director)
				.with('')
			get :similar, {:id => m1.id}
			response.should redirect_to(:root)
		end

		it 'redirect home if movie has empty director' do
			m1 = FactoryGirl.create(:movie, :director => nil)
			Movie.should_receive(:similar_movies_by_director)
				.with(nil)

			get :similar, {:id => m1.id}
			response.should redirect_to(:root)
		end

		it 'return movies filtered by director', :focus => true do
			m1 = FactoryGirl.create(:movie, :director => 'Patrick')
			m2 = FactoryGirl.create(:movie, :director => 'Patrick')
			m3 = FactoryGirl.create(:movie, :director => 'I-Am-Not-Patrick')
			mock_movies = [m1, m2]

			get :similar, {:id => m1.id}
			assigns(:movies).should match_array(mock_movies)
		end

	end

	describe 'viewing all movies' do

		it 'get all ratings' do
			Movie.all_ratings.should match_array(['G', 'PG', 'PG-13', 'NC-17', 'R'])
		end

		it 'makes available movies in the view' do
			movie1 = FactoryGirl.create(:movie)
			movie2 = FactoryGirl.create(:movie)
			mock_movies = [movie1, movie2]

			post :index
			assigns(:movies).should match_array(mock_movies)
		end

		it 'sorts by date' do
			FactoryGirl.create(:movie, :release_date => Time.now)
			FactoryGirl.create(:movie, :release_date => (Time.now + 10.days))

			get :index, {:sort => 'release_date', :ratings => {}}
			assigns(:movies).first.release_date.should <= assigns(:movies).last.release_date
		end

		it 'sorts by title' do
			FactoryGirl.create(:movie, :title => "Alibaba")
			FactoryGirl.create(:movie, :title => "Zengarden")

			get :index, {:sort => 'title', :ratings => {}}
			assigns(:movies).first.title.should <= assigns(:movies).last.title
		end

	end

	describe 'view a single movie' do
		it 'render the show view' do
			mov = FactoryGirl.create(:movie)

			get :show, {:id => mov.id}
			response.should render_template(:show)
		end

		it 'show movie info' do
			mov = FactoryGirl.create(:movie)

			get :show, {:id => mov.id}
			assigns(:movie).should eq(mov)
		end
	end

	describe 'delete a movie' do
		it 'deletes an existing movie' do
			mov = FactoryGirl.create(:movie)

			expect {
				delete :destroy, {:id => mov.id}
				}.to change(Movie, :count).by(-1)
		end

		it 'flashs a notice' do 
			mov = FactoryGirl.create(:movie)

			delete :destroy, {:id => mov.id}
			flash[:notice].should == "Movie '#{mov.title}' deleted."
		end

		it 'redirects to index' do 
			mov = FactoryGirl.create(:movie)

			delete :destroy, {:id => mov.id}
			response.should redirect_to(movies_path)
		end
	end

	describe 'create a movie' do
		it 'creates a new movie' do
			mov = FactoryGirl.build(:movie)

			expect {
				post :create, {:movie => {:title => mov.title,
				 :director => mov.director, :rating => mov.rating,
				 :description => mov.description, :release_date => mov.release_date}}
				}.to change(Movie, :count).by(1)
		end

		it 'flashs a notice' do 
			mov = FactoryGirl.build(:movie)

			post :create, {:movie => {:title => mov.title,
				 :director => mov.director, :rating => mov.rating,
				 :description => mov.description, :release_date => mov.release_date}}
			flash[:notice].should == "#{mov.title} was successfully created."
		end

		it 'redirects to index' do 
			mov = FactoryGirl.build(:movie)

			post :create, {:movie => {:title => mov.title,
				 :director => mov.director, :rating => mov.rating,
				 :description => mov.description, :release_date => mov.release_date}}
			response.should redirect_to(movies_path)
		end
	end

	describe 'edit a movie' do
		it 'finds a movie in the db to edit' do
			mov = FactoryGirl.create(:movie)

			post :edit, {:id => mov.id}
			assigns(:movie).should eq(mov)
		end
	end

	describe 'update a movie' do
		it 'edits the movie info' do
			mov = FactoryGirl.create(:movie)

			put :update, {:id => mov.id, :movie => {:title => "New Title"}}
			mov.reload
			mov.title.should == "New Title"

		end
	end

end
