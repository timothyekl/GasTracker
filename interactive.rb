require 'data_mapper'
Dir.glob('./models/*.rb').each { |f| require f }
DataMapper.setup(:default, "sqlite::memory:")
DataMapper.auto_upgrade!
DataMapper.finalize

require 'uri'
require 'net/http'
def post(uri, data = {})
  res = Net::HTTP.post_form(URI.parse(uri), data)
  return res.body
end
