class FooController < ApplicationController
  def search
    params[:query] = 'tmk' unless params[:query].present?
    searcher = SangeethapriyaSearcher.new("http://www.sangeethapriya.org/fs_search.php", params[:query])
    @results = searcher.results
    @ragas = YAML.load_file('config/raga.yml')
  end
end
