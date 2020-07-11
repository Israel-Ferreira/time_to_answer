# frozen_string_literal: true

module ApplicationHelper
  def translate_attribute(object = nil, attribute = nil)
    if object && attribute
      object.model.human_attribute_name(attribute)
    else
      'Informe os parâmetros corretamente! '
    end
  end

  def translate_model(object, count = 1)
    object.model_name.human(count: count)
  end
end
