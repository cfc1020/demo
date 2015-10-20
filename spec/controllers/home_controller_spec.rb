require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "check equation builder" do
    it "quadratic equation type" do
      xhr :get, :calculate, equation: { equation_type: :quadratic_equation }

      expect(assigns(:equation)).to be_a(QuadraticEquationForm)
    end
    
    it "linear equation type" do
      xhr :get, :calculate, equation: { equation_type: :linear_equation }

      expect(assigns(:equation)).to be_a(LinearEquationForm)
    end
    
    it "unknown type" do
      expect { xhr :get, :calculate, equation: { equation_type: :blah } }.to raise_error(String)
    end
    
    it "blank type" do
      expect { xhr :get, :calculate }.to raise_error(String)
    end
  end
  
  describe "check calculate action" do
    it "renders the calculate template" do
      xhr :get, :calculate, equation: { equation_type: :quadratic_equation }
      
      expect(response).to render_template("calculate")
    end
    
    it "assign params and calculated roots" do
      quadratic_equation = QuadraticEquationForm.new a: '6.0', b: '6', c: 0.0, equation_type: :quadratic_equation
      quadratic_equation.calculate!
      quadratic_equation_attributes = quadratic_equation.attributes

      xhr :get, :calculate, equation: quadratic_equation_attributes

      expect(assigns(:equation).attributes.to_a).to match_array(quadratic_equation_attributes.to_a)
      expect(assigns(:equation).roots).to match_array(quadratic_equation.roots)
    end
  end
end
