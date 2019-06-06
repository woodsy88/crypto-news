module ApplicationHelper


   #gets called in view
  def alerts
    #checking to see if params hash in flash msg has a value
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  #creating a flash method, then gets called in above alerts method
  def alert_generator msg
    js add_gritter(msg, title: "Crypto-Grapher", sticky: false)
  end

end
