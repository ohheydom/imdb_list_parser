# ImdbListParser

ImdbListParser parses the Top 250 and Bottom 100 lists from the Internet Movie Database. The gem creates an array of the movies with optional parameters, years and ratings.

## Installation

Add this line to your application's Gemfile:

    gem 'imdb_list_parser', git: 'git://github.com/ohheydom/imdb_list_parser.git'

And then execute:

    $ bundle

## Usage

To create an array with the movie titles of the Top 250 movies, simply type:

```ruby
ImdbListParser::Top250.movies
```

Or for the Bottom 100 films:

```ruby
ImdbListParser::Bottom100.movies
```

To create an array of arrays with more information alongside the movie title, such as year or rating, use the `display` method.

```ruby
ImdbListParser::Top250.display(:years, :ratings)
```
