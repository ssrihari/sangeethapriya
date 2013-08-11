class SangeethapriyaSearcher
  include HTTParty

  def initialize(url, query)
    @url = url
    @query = query
  end

  def document
    response = HTTParty.post @url, query: { q: @query }
    @document ||= Nokogiri::HTML(response.parsed_response)
  end

  def results
    @results ||= document.css("#searchresults li").inject([]) do |array, result|
      array << { track: track(result), album: album(result), link: link(result), hostname: hostname(result)}
    end
  end

  def only_sangeethapriya_results
    results.select {|result| result[:hostname] == "www.sangeethapriya.org"}
  end

  def track(result)
    result.text.gsub(/mp3.+/, "mp3")
  end

  def album(result)
    result.css("a").text
  end

  def hostname(result)
    link = result.css("a").attr("href").value()
    return "www.sangeethapriya.org" if link.include?("sangeethapriya.org")
    return "www.sangeethamshare.org" if link.include?("sangeethamshare.org")
  end

  def link(result)
    host = hostname(result)
    folder_link = result.css("a").attr("href").value()
    folder_link.gsub!("http://#{host}/","")
    filename = track(result)
    action = "http://#{host}/fstream.php\?"
    prefix = "file\=/data/#{host}/public_html/"
    "#{action}#{prefix}#{folder_link}/#{filename}"
  end
end
