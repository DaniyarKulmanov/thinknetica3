# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*variables)
    variables.each do |variable|
      raise TypeError, 'variable name must be symbol' unless variable.is_a?(Symbol)

      define_method(variable) do
        instance_variable_get("@#{variable}")
      end
      define_method("#{variable}=") do |value|
        instance_variable_set("@#{variable}", value)
        instance_variable_set("@#{variable}_history", []) if instance_variable_get("@#{variable}_history").nil?
        instance_variable_get("@#{variable}_history").push(value)
      end
      define_method("#{variable}_history") do
        instance_variable_get("@#{variable}_history")
      end
    end
  end
end