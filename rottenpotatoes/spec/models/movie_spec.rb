require 'spec_helper'

describe Movie do
	it 'gets all ratings' do
		Movie.all_ratings.should == ['G', 'PG', 'PG-13', 'NC-17', 'R']
	end
end
