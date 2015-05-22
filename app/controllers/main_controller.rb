class MainController < ApplicationController
  include MainHelper
  require 'rinruby'

  def index
  end

  def r_script
    r = RinRuby.new
    n = 10
    beta_0 = 1
    beta_1 = 0.25
    alpha = 0.05
    seed = 23423
    R.x = (1..n).entries
    R.eval <<-EOF
        set.seed(#{seed})
        y <- #{beta_0} + #{beta_1}*x + rnorm(#{n})
        fit <- lm( y ~ x )
        est <- round(coef(fit),3)
        pvalue <- summary(fit)$coefficients[2,4]
    EOF
    statement =  "E(y|x) ~= #{R.est[0]} + #{R.est[1]} * x"
    if R.pvalue < alpha
      response = "Reject the null hypothesis and conclude that x and y are related."
    else
      response = "There is insufficient evidence to conclude that x and y are related."
    end
    @results = [statement, response]
    r.quit
    r = RinRuby.new(false)
  end
end
