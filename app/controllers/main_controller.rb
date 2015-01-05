class MainController < ApplicationController
  include MainHelper
  require 'rinruby'

  def index
  end

  def r_script
    script = params[:script]

    if script == 'Chick Weights'
      chick_weights
    elsif script == 'Random Barplot'
      random_barplot
    elsif script == 'Color Styles'
      color_styles
    elsif script == 'Overlayed Histogram'
      overlayed_histogram
    end

    @script = script

  end
end
