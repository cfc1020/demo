class QuadraticEquationForm < BaseEquationForm
  fields :a, :b, :c
  
  validates :a, presence: true
  validates :b, presence: true
  validates :c, presence: true
  
  before_validation :check_discriminant

  def calculate!
    return false if invalid?
    
    [x1, x2]
  end
  
  private
  
  def discriminant
    @discriminant ||= b * b - 4 * a * c
  end
  
  def sqrt_from_discriminant
    @sqrt_from_discriminant ||= Math.sqrt @discriminant
  end
  
  def x1
    @x1 ||= (-b + sqrt_from_discriminant) / 2 * a
  end
  
  def x2
    @x2 ||= (-b - sqrt_from_discriminant) / 2 * a
  end
  
  def check_discriminant
    self.errors.add :base, 'There are no real roots, because discriminant is negative' if discriminant < 0
  end
end
