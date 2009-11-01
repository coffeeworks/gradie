module Gradie
  class Image
    def initialize(filename, opts = {}, &block)
      @filename = filename
      @options = opts
      
      puts "Generating #{self.full_path}..."
      self.instance_eval(&block)
    end
    
    def gradient(color1, color2, opts = {})
      puts 'gradient'
    end
    
    def solid(color, opts = {})
      puts 'solid'
    end
    
    def full_path
      @options[:dir] + '/' + @filename
    end
  end
end