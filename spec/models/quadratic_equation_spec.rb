require 'rails_helper'

RSpec.describe QuadraticEquationForm, type: :model do
  it "Two identical roots" do
    quadratic_equation = QuadraticEquationForm.new a: 10, b: 20.0, c: 10

    quadratic_equation.calculate!

    expect(quadratic_equation.roots).to match_array([-1, -1])
  end
  
  it "Two different roots" do
    quadratic_equation = QuadraticEquationForm.new a: '6.0', b: '6', c: 0.0
    
    quadratic_equation.calculate!

    expect(quadratic_equation.roots).to match_array([-1, 0])
  end
  
  it "Without the third argument" do
    quadratic_equation = QuadraticEquationForm.new a: 10, b: 20
    
    quadratic_equation.calculate!

    expect(quadratic_equation).to be_invalid
  end
  
  it "There are no real roots, because discriminant is negative" do
    quadratic_equation = QuadraticEquationForm.new a: 60, b: 6, c: 606
    
    quadratic_equation.calculate!

    expect(quadratic_equation.errors[:base]).to include('There are no real roots, because discriminant is negative')
  end
  
  it "Third argument string, but not number" do
    quadratic_equation = QuadraticEquationForm.new a: 0, b: '0', c: 'eww'
    
    quadratic_equation.calculate!

    expect(quadratic_equation).to be_invalid
  end
end
