class HomeController < ApplicationController
  def index
  end

  def calculate
    @equation = equation_builder equation_params
    @equation.calculate!
  end
  
  private
  
  def equation_builder(equation_params)
    equation_class = case equation_params[:equation_type].to_sym
    when :quadratic_equation
      QuadraticEquationForm
    when :linear_equation
      LinearEquationForm
    else
      raise 'Wrong type of equation!'
    end
    
    equation_class.new equation_params
  end
  
  def equation_params
    params.require(:equation).permit(:a, :b, :c, :equation_type)
  end
end
