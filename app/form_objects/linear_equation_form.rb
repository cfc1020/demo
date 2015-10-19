class LinearEquationForm < BaseEquationForm
  fields a: Float, b: Float
  
  validates :a, presence: true
  validates :b, presence: true
  
  validates :a, numericality: true, allow_blank: true
  validates :b, numericality: true, allow_blank: true

  validate :check_variables

  def calculate!
    return false if invalid?
    
    calculate_roots!
  end
  
  def html_id
    '#new_linear_equation'
  end
  
  def form_path
    'home/linear_equation_form'
  end
  
  private
  
  def calculate_roots!
    @roots ||= [x]
  end
  
  def x
    @x ||= -b / a
  end
  
  def check_variables
    return if self.errors.present? || a.nonzero?
    
    error = b.nonzero? ? 'There are no roots' : 'Every number is a solution of the equation'

    self.errors.add :base, error
  end
end
