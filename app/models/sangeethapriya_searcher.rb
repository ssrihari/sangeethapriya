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
      array << { track: track(result), album: album(result), link: link(result) }
    end
  end

  def track(result)
    result.text
  end

  def album(result)
    result.css("a").text
  end

  def get_hostname(link)
    return "www.sangeethapriya.org" if link.include?("sangeethapriya.org")
    return "www.sangeethamshare.org" if link.include?("sangeethamshare.org")
  end

  def link(result)
    folder_link = result.css("a").attr("href").value()
    hostname = get_hostname(folder_link)
    folder_link.gsub!("http://#{hostname}/","")
    filename = track(result).gsub(/mp3.+/, "mp3")
    action = "http://#{hostname}/fstream.php\?"
    prefix = "file\=/data/#{hostname}/public_html/"
    "#{action}#{prefix}#{folder_link}/#{filename}"
  end
end
