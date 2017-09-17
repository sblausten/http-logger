require 'json'

class Writer
  def write_to_console(content)
    $stdout.puts content.to_json
  end
end
