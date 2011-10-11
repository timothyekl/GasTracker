class Purchase
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :gallons, Float
  property :miles, Float
  property :cost, Float

  belongs_to :driver
  belongs_to :car

  validates_numericality_of :miles, :gte => 0.0
  validates_numericality_of :gallons, :gte => 0.0
  validates_numericality_of :cost, :gte => 0.0

  def miles_per_gallon
    return self.miles / self.gallons
  end

  def cost_per_gallon
    return self.cost / self.gallons
  end
end
