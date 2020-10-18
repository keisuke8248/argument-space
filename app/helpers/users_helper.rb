module UsersHelper

  def rate(good, bad)
    denominator = (good + bad)
    if denominator != 0
      rate =  (good.to_f / denominator) * 100
      return rate.round(1)
    else
      return "---"
    end
  end

end
