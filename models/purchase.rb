class GasPurchase
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :gallons, Float
  property :miles, Float

  has 1, :driver

  belongs_to :car
end
