require File.expand_path(File.dirname(__FILE__) + '/../lib/gradie')

Gradie::Images.new(:dir => './output') do
  image('background-header.png', :width => 5) do
    gradient :white, '#BCBCBC', :height => 50
    solid :red, :height => 10
    gradient '#BCBCBC', :transparent, :height => 50
  end
end
