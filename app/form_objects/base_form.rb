class BaseForm
  include ActiveModel::Model

  class_attribute :attributes, instance_writer: false

  def self.fields(*names)
    self.attributes = Array(names)
    self.send :attr_accessor, *attributes
  end

  def persisted?
    false
  end
end
