class QuadraticEquationForm < BaseEquationForm
  fields a: Float, b: Float, c: Float
  
  validates :a, presence: true
  validates :b, presence: true
  validates :c, presence: true
  
  validates :a, numericality: true, allow_blank: true
  validates :b, numericality: true, allow_blank: true
  validates :c, numericality: true, allow_blank: true
  
  validate :check_discriminant

  def calculate!
    return false if invalid?

    calculate_roots!
  end
  
  def html_id
    '#new_quadratic_equation'
  end
  
  def form_path
    'home/quadratic_equation_form'
  end
  
  private
  
  def calculate_roots!
    @roots ||= [x1, x2]
  end
  
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
    return if self.errors.present?

    self.errors.add :base, 'There are no real roots, because discriminant is negative' if discriminant < 0
  end
end
