require './src/request'
require './src/writer'
require './src/input'

request = Request.new
writer = Writer.new
input = Input.new

loop do
  begin
    writer.write_to_console(
      request.get_headers(
        input.get_console_input
      )
    )
  rescue => e
    $stderr.puts e
  end
end
