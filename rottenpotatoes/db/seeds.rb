# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [{:title => 'Aladdin', :rating => 'G', :director => nil, :release_date => '25-Nov-1992'},
    	  {:title => 'The Terminator', :rating => 'R', :director => '', :release_date => '26-Oct-1984'},
    	  {:title => 'When Harry Met Sally', :director => 'Hello 1', :rating => 'R', :release_date => '21-Jul-1989'},
      	  {:title => 'The Help', :director => 'Hello 2', :rating => 'PG-13', :release_date => '10-Aug-2011'},
      	  {:title => 'Chocolat', :director => 'Hello 2',:rating => 'PG-13', :release_date => '5-Jan-2001'},
      	  {:title => 'Amelie', :director => 'Hello 3', :rating => 'R', :release_date => '25-Apr-2001'},
      	  {:title => '2001: A Space Odyssey', :director => 'Hello 3',:rating => 'G', :release_date => '6-Apr-1968'},
      	  {:title => 'The Incredibles', :director => 'Hello 5', :rating => 'PG', :release_date => '5-Nov-2004'},
      	  {:title => 'Raiders of the Lost Ark', :director => 'Hello 6',:rating => 'PG', :release_date => '12-Jun-1981'},
      	  {:title => 'Chicken Run', :director => 'Hello 6', :rating => 'G', :release_date => '21-Jun-2000'},
  	 ]

movies.each do |movie|
  Movie.create!(movie)
end