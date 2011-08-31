class Car
  include DataMapper::Resource

  property :id, Serial
  property :description, String

  has n, :gas_purchases
  has n, :drivers
end
