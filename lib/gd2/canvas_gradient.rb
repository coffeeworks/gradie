require 'rubygems'
require 'gd2'

# monkey patch in a gradient method
module GD2
  class Canvas
    def gradient(x1, y1, x2, y2, r1, g1, b1, r2, g2, b2)
      height = y2 - y1
      r_delta = (r1 - r2) / height
      g_delta = (g1 - g2) / height
      b_delta = (b1 - b2) / height

      my_y = y1
      my_r = r1
      my_g = g1
      my_b = b1

      0.upto(height) do |i|
        self.color = @image.palette.resolve Color[my_r, my_g, my_b]
        self.rectangle(x1, my_y, x2, my_y + 1, true)

        my_y += 1
        my_r -= r_delta
        my_g -= g_delta
        my_b -= b_delta
      end
    end
  end
end