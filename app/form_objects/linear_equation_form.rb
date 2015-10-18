class LinearEquationForm < BaseEquationForm
  fields :a, :b
  
  validates :a, presence: true
  validates :b, presence: true

  before_validation :check_variables

  def calculate!
    return false if invalid?
    
    [x]
  end
  
  private
  
  def x
    @x ||= -b / a
  end
  
  def check_variables
    return if a.nonzero?
    
    error = b.nonzero? ? 'There are no roots' : 'Every number is a solution of the equation'

    self.errors.add :base, error
  end
end
