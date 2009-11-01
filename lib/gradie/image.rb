module Gradie
  class Image
    def initialize(filename, opts = {}, &block)
      @filename = filename
      
      defaults = { :width => 1, :height => 1 }
      @options = defaults.merge!(opts)
      @vertical = true
      
      @x = @y = @width = @height = 0
      
      puts "Generating #{self.full_path}..."

      self.check_size(&block)
      self.write_image(&block)      
            
      puts "  Image size: #{@width}x#{@height}"
    end
    
    def gradient(color1, color2, opts = {})
      opts = @options.merge(opts)      
      if self.dry_run?
        self.update_size(opts[:width], opts[:height])
      else
        color1 = Gradie::Color.new(color1)
        color2 = Gradie::Color.new(color2)
        @image.draw do |pen|
          x2 = @x + opts[:width]
          y2 = @y + opts[:height]
          pen.gradient(@x, @y, x2, y2, color1.r, color1.g, color1.b, color2.r, color2.g, color2.b)
          
          if @vertical
            @y = y2
          else
            @x = x2
          end
        end
        puts 'gradient' if @verbose
      end 
    end
    
    def solid(color, opts = {})
      opts = @options.merge(opts)      
      if self.dry_run?
        self.update_size(opts[:width], opts[:height])
      else
        gcolor = Gradie::Color.new(color)
        @image.draw do |pen|
          x2 = @x + opts[:width]
          y2 = @y + opts[:height]
          pen.color = gcolor.to_gd2
          pen.rectangle(@x, @y, x2, y2, true)
          
          if @vertical
            @y = y2
          else
            @x = x2
          end
        end
        puts 'solid' if @verbose
      end
    end

    protected
    
    # Performs a dry run just to check the final image size
    def check_size(&block)
      self.instance_eval(&block)
    end

    # Performs the actual image generation
    def write_image(&block)
      @image = GD2::Image.new(@width, @height)
      self.instance_eval(&block)
      @image.export(self.full_path)
    end
    
    # Keep track of the size of the bounding box
    def update_size(width, height)      
      if @vertical
        @height += height
        @width = width if width > @width
      else
        @width += width
        @height = height if height > @height
      end
    end
    
    # Output file path
    def full_path
      @options[:dir] + '/' + @filename
    end
    
    def dry_run?
      @image.nil?
    end
  end
end