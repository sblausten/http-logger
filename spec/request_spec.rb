
describe 'get_headers' do
  before(:each) do
    @request = Request.new
    WebMock.disable_net_connect!
  end
  context 'valud url' do
    it 'returns header response in hash when passed valid url' do
      valid_url = 'http://google.com'
      expected_headers = {
        Url: nil,
        Status_code: '302',
        Content_length: 271,
        Date: 'Sun, 17 Sep 2017 16:00:00 GMT'
      }
      stub = stub_request(:get, valid_url)
             .with(headers: { 'Accept' => '*/*' })
             .to_return(status: 302, headers: {
                          'Content-Length' => 271,
                          'Date' => 'Sun, 17 Sep 2017 16:00:00 GMT'
                        })
      expect(@request.get_headers(valid_url)).to eq(expected_headers)
      expect(stub).to have_been_requested
    end
    it 'returns header response for valid url that does not exist' do
      valid_url = 'http://not.exists.bbc.co.uk/'
      expected_headers = {
        Url: nil,
        Status_code: '404',
        Content_length: 0,
        Date: 'Sun, 17 Sep 2017 16:00:00 GMT'
      }
      stub = stub_request(:get, valid_url)
             .with(headers: { 'Accept' => '*/*' })
             .to_return(status: 404,
                        headers: {
                          'Content-Length' => 0,
                          'Date' => 'Sun, 17 Sep 2017 16:00:00 GMT'
                        })
      expect(@request.get_headers(valid_url)).to eq(expected_headers)
      expect(stub).to have_been_requested
    end
  end
  context 'invalid url' do
    it 'returns invalid request hash when passed invalid url' do
      invalid_url = 'bad://address'
      expected = { Url: invalid_url, Error: 'invalid url' }
      expect(@request.get_headers(invalid_url)).to eq(expected)
    end
    it 'returns invalid request hash when passed url that times out' do
      timeout_url = 'https://httpstat.us/522'
      expected = { Url: timeout_url, Error: 'invalid url' }
      stub_request(:get, timeout_url).to_timeout
      expect(@request.get_headers(timeout_url)).to eq(expected)
    end
  end
end
