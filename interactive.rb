require 'data_mapper'
Dir.glob('./models/*.rb').each { |f| require f }
DataMapper.setup(:default, "sqlite::memory:")
DataMapper.auto_upgrade!
DataMapper.finalize
