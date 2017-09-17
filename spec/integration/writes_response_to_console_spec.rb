require 'json'

describe 'Valid url' do
  it 'writes json to STDOUT with header response from http request' do
    request = Request.new
    writer = Writer.new
    input = Input.new
    valid_url = 'http://google.com'
    expected = {
      Url: nil,
      Status_code: '302',
      Content_length: 271,
      Date: 'Sun, 17 Sep 2017 16:00:00 GMT'
    }.to_json + "\n"

    stub = stub_request(:get, valid_url)
           .with(headers: { 'Accept' => '*/*' })
           .to_return(status: 302, headers: {
                        'Content-Length' => 271,
                        'Date' => 'Sun, 17 Sep 2017 16:00:00 GMT'
                      })

    expect do
      writer.write_to_console(
        request.get_headers(
          valid_url
        )
      )
    end.to output(expected).to_stdout
  end
end

describe 'Invalid url' do
  it 'writes json to STDOUT notifying that url was invalid' do
    request = Request.new
    writer = Writer.new
    input = Input.new
    invalid_url = 'bad://url'
    expected = { Url: invalid_url, Error: 'invalid url' }.to_json + "\n"

    stub = stub_request(:get, invalid_url)
           .with(headers: { 'Accept' => '*/*' })
           .to_return(status: 404, headers: {
                        'Content-Length' => 0,
                        'Date' => 'Sun, 17 Sep 2017 16:00:00 GMT'
                      })

    expect do
      writer.write_to_console(
        request.get_headers(
          invalid_url
        )
      )
    end.to output(expected).to_stdout
  end
end
