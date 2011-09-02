class Driver
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :cars, :through => Resource
  has n, :purchases
end
