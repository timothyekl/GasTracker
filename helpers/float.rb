class Float
  def format_gallons
    return "%.3f" % self
  end

  def format_cost
    return "$%.2f" % self
  end

  def format_miles
    return "%.1f" % self
  end

  def _round_to(places)
    return ((10.0 ** places) * self).round / (10.0 ** places)
  end
end
