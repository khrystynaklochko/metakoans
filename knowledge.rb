class Module

  def attribute(var, &block)

    if var.is_a?(Hash)
      name = var.keys.first
      value = var.values.first
    else
      name = var
      value = nil
    end
    define_method(:"#{name}?") { send(:"#{name}") }
    define_method(:"#{name}=") { |value| instance_variable_set(:"@#{name}", value) }
    define_method(:"#{name}") do
      if instance_variable_defined?(:"@#{name}")
        instance_variable_get(:"@#{name}")
      else
        (block_given?) ? instance_eval(&block) : value
      end
    end
  end

end