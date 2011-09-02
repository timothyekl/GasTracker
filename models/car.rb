class Car
  include DataMapper::Resource

  property :id, Serial
  property :description, String

  has n, :purchases
  has n, :drivers, :through => Resource
end
