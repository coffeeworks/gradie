module Gradie
  
  # Simple color parser
  class Color
    HTML4_COLORS = {
      'black' => '#000000',
      'silver' => '#c0c0c0',
      'gray' => '#808080',
      'white' => '#ffffff',
      'maroon' => '#800000',
      'red' => '#ff0000',
      'purple' => '#800080',
      'fuchsia' => '#ff00ff',
      'green' => '#008000',
      'lime' => '#00ff00',
      'olive' => '#808000',
      'yellow' => '#ffff00',
      'navy' => '#000080',
      'blue' => '#0000ff',
      'teal' => '#008080',
      'aqua' => '#00ffff'
    }
    
    attr_accessor :r, :g, :b
    
    def initialize(code)
      if code.is_a? Symbol
        hex = HTML4_COLORS[code.to_s]
      else
        hex = code
      end
      
      self.from_hex(hex)      
    end
    
    def rgb
      [@r, @g, @b]
    end
    
    def to_gd2
      GD2::Color[@r, @g, @b]
    end
    
    protected
    
    def from_hex(hex)
      m = hex.match /#?(..)(..)(..)/

      @r = m[1].hex/255.0
      @g = m[2].hex/255.0
      @b = m[3].hex/255.0
    end
  end
end