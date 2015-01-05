module MainHelper
  def chick_weights
    r = RinRuby.new
    r.eval <<-EOF
      data(chickwts)
      png(filename= '#{Rails.root}/app/assets/images/chickwts.png',
          width = 800,
          height = 600)
      plot(chickwts$feed)
      dev.off()
    EOF
    r.quit
    r = RinRuby.new(false)
  end

  def random_barplot
    r = RinRuby.new
    rand_array = []
    8.times do 
      num = rand(1..10)
      rand_array << num
    end
    r.eval "random_vector <- c(#{rand_array.join(', ')})"
    r.eval "demo_data_frame <- data.frame(random_vector)"

    r.eval <<-EOF
      # set color pallete
      require("RColorBrewer")
      colors <- brewer.pal(8, "Blues")

      png(filename= '#{Rails.root}/app/assets/images/random_barplot.png',
      width = 800,
      height = 600)
      barplot(demo_data_frame$random_vector, col = colors)
      dev.off()
    EOF
    r.quit
    r = RinRuby.new(false)
  end

  def overlayed_histogram
    r = RinRuby.new
    r.eval <<-EOF
      # set color pallete
      require("RColorBrewer")
      pastels <- brewer.pal(15, "Pastel2")

      png(filename= '#{Rails.root}/app/assets/images/overlayed_hist.png',
      width = 800,
      height = 600)
      pl <- swiss$Education
      hist(pl,
           prob = TRUE,
           breaks = 12,
           col = pastels,
           border = 0,
           main = "Swiss Education")

      lines(density(pl), col = "darkred", lwd = 2)

      rug(pl, col = "darkgray", lwd = 2)

      dev.off()
    EOF
    r.quit
    r = RinRuby.new(false)
  end


  def color_styles
    r = RinRuby.new
    r.eval <<-EOF

      png(filename= '#{Rails.root}/app/assets/images/color_styles.png',
      width = 800,
      height = 600)

      # # Using R's built-in palettes
      # n <- 5
      # x <- c(rep(10, n))
      # barplot(x, col = rainbow(n))

      # # sequential values
      # n <- 8
      # x <- c(rep(10, n))
      # barplot(x, col = heat.colors(n))

      # # divergent values
      # n <- 11
      # x <- c(rep(10, n))
      # barplot(x, col = cm.colors(n))

      # Using RColorBrewer
      require("RColorBrewer")
      display.brewer.all()

      dev.off()

    EOF

    r.quit
    r = RinRuby.new(false)
  end


end
