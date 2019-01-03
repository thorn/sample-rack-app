require 'rack'
require 'mysql2'

class ConnectionTester
  def call(env)
    response = databases.map { |db| "<li>#{db}</li>"}.join()
    [200, {"Content-Type" => "text/html"}, ["<ul>#{response}</ul>"]]
  end

  def databases
    client = Mysql2::Client.new(
      :host => ENV["RDS_HOST"],
      :username => ENV["RDS_USERNAME"],
      :password => ENV["RDS_PASSWORD"]
    )
    databases = client.query("SHOW DATABASES").map { |row| row["Database"] }
    client.close
    databases
  end
end

Rack::Handler::WEBrick.run ConnectionTester.new, :Host => "0.0.0.0", :Port => "80"
