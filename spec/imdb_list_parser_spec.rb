require 'vcr'
require 'webmock/rspec'
require_relative 'support/vcr_setup'
require 'imdb_list_parser'

describe ImdbListParser do
  describe 'Top250' do
    imdb_list = ImdbListParser::Top250
    describe '#movies' do
      it 'displays an array of all the movies in the list' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.movies).to be_a Array
        end
      end

      it 'includes an array of 250 objects' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.movies.count).to eq 250
        end
      end

      it 'includes movie titles like The Godfather and The Shawshank Redemption' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.movies).to include 'The Godfather', 'The Shawshank Redemption'
        end
      end
    end

    describe '#display with years' do
      it 'returns an array of arrays with the movie and year' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.display(:years)[0]).to eq(['The Shawshank Redemption', '1994'])
        end
      end
    end

    describe '#display with ratings' do
      it 'returns an array of arrays with the movie and rating' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.display(:ratings)[0]).to eq(['The Shawshank Redemption', '9.2'])
        end
      end
    end

    describe '#display with undefined method' do
      it 'returns an array of the movies' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.display(:fake_method)[0]).to eq(['The Shawshank Redemption'])
        end
      end
    end

    describe '#find_rank(movie)' do
      it 'returns the ranking of the movie if found' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.find_rank('The Godfather')).to eq 2
        end
      end

      it 'is case insensitive' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.find_rank('THE GODFATHER')).to eq 2
        end
      end

      it 'returns an error message if the movie is not found' do
        VCR.use_cassette('imdb_top_250') do
          expect(imdb_list.find_rank('Fake Movie')).to eq 'Unable to locate movie in the list.'
        end
      end
    end
  end

  describe 'Bottom 100' do
    imdb_list = ImdbListParser::Bottom100

    describe '#display with years' do
      it 'returns an array of arrays with the movie and year' do
        VCR.use_cassette('imdb_bottom_100') do
          expect(imdb_list.display(:years)[0]).to eq(['Code Name: K.O.Z.', '2015'])
        end
      end
    end

    describe '#display with ratings' do
      it 'returns an array of arrays with the movie and rating' do
        VCR.use_cassette('imdb_bottom_100') do
          expect(imdb_list.display(:ratings)[0]).to eq(['Code Name: K.O.Z.', '1.5'])
        end
      end
    end

    describe '#display with years and ratings' do
      it 'returns an array of arrays with the movie, year, and rating' do
        VCR.use_cassette('imdb_bottom_100') do
          expect(imdb_list.display(:years, :ratings)[0]).to eq(['Code Name: K.O.Z.', '2015', '1.5'])
        end
      end
    end
  end
end
