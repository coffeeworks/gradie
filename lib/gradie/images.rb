module Gradie
  class Images
    def initialize(opts = {}, &block)
      defaults = { :dir => './' }
      @options = defaults.merge!(opts)
      self.instance_eval(&block)
    end
    
    def image(filename, opts = {}, &block)
      Gradie::Image.new(filename, @options.merge(opts), &block)
    end
  end
end
