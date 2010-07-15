class Array
  alias :_product :product
  def product(*args, &block)
    args.empty? ? super : _product(*args, &block)
  end
end
