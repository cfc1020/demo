class BaseEquationForm < BaseForm
  include ActiveRecord::Callbacks
  
  fields equation_type: String
  
  attr_accessor :roots
end
