Rails.application.routes.draw do
  get 'admin/dashboard'
  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"

  get("/", :controller => "home", :action => "index")

  get("/reading", :controller => "books", :action => "index")
  post("/reading", :controller => "books", :action => "create")

  get("/career", :controller => "home", :action => "career")

  get("/hiking", :controller => "home", :action => "hiking")

  get("/admin", { :controller => "admin", :action => "dashboard" })
  get("/admin/books", { :controller => "admin", :action => "books" })
  
end
