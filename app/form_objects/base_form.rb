class BaseForm
  include ActiveModel::Model
  include Virtus.model

  def self.fields(names)
    names.each do |variable, type|
      self.attribute variable, type
    end
  end

  def persisted?
    false
  end
end
