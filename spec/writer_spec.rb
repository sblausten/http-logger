require 'json'
describe Writer do
  describe 'write_to_console' do
    it 'outputs json to STDOUT' do
      writer = Writer.new
      input = { test: 'test' }
      expected = input.to_json + "\n"
      expect { writer.write_to_console(input) }.to output(expected).to_stdout
    end
  end
end
