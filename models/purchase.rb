class GasPurchase
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :gallons, Float
  property :miles, Float
  property :cost, Float

  belongs_to :driver
  belongs_to :car
end
