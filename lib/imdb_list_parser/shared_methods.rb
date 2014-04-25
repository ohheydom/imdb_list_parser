module ImdbListParser
  module SharedMethods
    def movies
      @movies ||= elements.inject([]) { |acc, html| acc << html.elements[1].elements[1].inner_text }
    end

    def display(*options)
      movies.each_with_index.inject([]) do |acc, (mov, ind)|
        acc << ([mov] + valid_methods(options).map { |meth| meth[ind] })
      end
    end

    def find_rank(movie)
      ind = movies.map(&:downcase).index(movie.downcase) || 'Unable to locate movie in the list.'
      ind.to_s =~ /\d+/ ? ind + 1 : ind
    end

    private

    def elements
      @elements ||= html.css('tbody.lister-list tr').inject([]) { |acc, elements| acc << elements }
    end

    def html
      @html ||= Nokogiri::HTML(open(@url))
    end

    def years
      @years ||= elements.inject([]) { |acc, html| acc << html.elements[1].elements[2].inner_text[/\d+/] }
    end

    def ratings
      @ratings ||= elements.inject([]) { |acc, html| acc << html.elements[2].elements.inner_text }
    end

    def valid_methods(arr)
      arr.map { |meth| instance_eval(meth.to_s) if SharedMethods.private_method_defined?(meth) }.compact
    end
  end
end
