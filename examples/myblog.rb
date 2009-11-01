require File.expand_path(File.dirname(__FILE__) + '/../lib/gradie')

Gradie::Images.new(:dir => './examples/output') do
  image('background-header.png', :width => 5) do
    gradient :white, '#DADADA', :height => 50
    solid :red, :height => 10
    gradient :red, :black, :height => 50
  end
end
