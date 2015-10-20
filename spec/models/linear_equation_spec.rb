require 'rails_helper'

RSpec.describe LinearEquationForm, type: :model do
  it "Negative root" do
    linear_equation = LinearEquationForm.new a: 10, b: 20.0
    
    linear_equation.calculate!

    expect(linear_equation.roots).to eq([-2])
  end
  
  it "Positive root" do
    linear_equation = LinearEquationForm.new a: '10', b: '-20.0'
    
    linear_equation.calculate!

    expect(linear_equation.roots).to eq([2])
  end
  
  it "There are no roots" do
    linear_equation = LinearEquationForm.new a: 0, b: 20
    
    linear_equation.calculate!

    expect(linear_equation.errors[:base]).to include('There are no roots')
  end
  
  it "Every number is a solution of the equation" do
    linear_equation = LinearEquationForm.new a: 0, b: 0
    
    linear_equation.calculate!

    expect(linear_equation.errors[:base]).to include('Every number is a solution of the equation')
  end
  
  it "Without the second argument" do
    linear_equation = LinearEquationForm.new a: 0
    
    linear_equation.calculate!

    expect(linear_equation).to be_invalid
  end
  
  it "First argument string, but not number" do
    linear_equation = LinearEquationForm.new a: '31212', b: 'sds'
    
    linear_equation.calculate!

    expect(linear_equation).to be_invalid
  end
end
