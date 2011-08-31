class Driver
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :cars
  has n, :gas_purchases
end
