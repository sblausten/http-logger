
class Request
  def get_headers(url)
    response = make_request(url)
    extract_headers(response)
  end

  private

  def make_request(url)
    Net::HTTP.get_response(get_uri(url))
  rescue => e
    STDERR.puts e
  end

  def get_uri(url)
    encoded_url = URI.encode(url)
    URI.parse(encoded_url)
  end

  def extract_headers(response)
    {
      Url: response.uri,
      Status_code: response.code,
      Content_length: response.content_length,
      Date: get_date(response)
    }
  rescue => e
    STDERR.puts e
  end

  def get_date(res)
    res.each_header do |key, value|
      return value if key == 'date'
    end
  end
end
