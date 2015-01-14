Rails.application.routes.draw do

  get("/", { :controller => "pages", :action => "home" })

  get("/test", { :controller => "forecasts", :action => "location" })

end
