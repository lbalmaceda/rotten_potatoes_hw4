require 'spec_helper'

describe MoviesHelper do
	describe 'calculates odd numbers' do
		it 'answer if a number is even' do
			oddness(2).should =="even"
		end

		it 'answer if a number is odd' do
			oddness(3).should =="odd"
		end
	end
end