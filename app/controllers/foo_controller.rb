class FooController < ApplicationController
  def search
    raga = params[:raga] || 'kalyani'
    searcher = SangeethapriyaSearcher.new("http://www.sangeethapriya.org/fs_search.php", raga)
    @results = searcher.results
  end
end
