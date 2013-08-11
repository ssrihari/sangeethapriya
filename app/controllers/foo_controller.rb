class FooController < ApplicationController
  def search
    raga = params[:raga] || 'tmk'
    searcher = SangeethapriyaSearcher.new("http://www.sangeethapriya.org/fs_search.php", raga)
    @results = searcher.only_sangeethapriya_results
    @ragas = YAML.load_file('config/raga.yml')
  end
end
