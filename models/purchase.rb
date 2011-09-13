class Purchase
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :gallons, Float
  property :miles, Float
  property :cost, Float

  belongs_to :driver
  belongs_to :car

  def miles_per_gallon
    return self.miles / self.gallons
  end

  def cost_per_gallon
    return self.cost / self.gallons
  end
end
