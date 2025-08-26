Rails.application.routes.draw do
  get 'admin/dashboard'
  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"

  get("/", :controller => "home", :action => "index")

  get("/reading", :controller => "books", :action => "index")
  get("/reading/:book_id", :controller => "books", :action => "show")
  patch("/reading/:book_id", { :controller => "books", :action => "update" })
  post("/reading", :controller => "books", :action => "create")
  delete("/reading/:book_id", { :controller => "books", :action => "destroy" })

  get("/career", :controller => "home", :action => "career")

  get("/hiking", :controller => "hiking", :action => "index")

  get("/notebook", :controller => "notebook_entries", :action => "index")
  get("/notebook/new", { :controller => "notebook_entries", :action => "new_entry_form" })
  get("/notebook/:notebook_entry_id", :controller => "notebook_entries", :action => "show")
  get("/notebook/:notebook_entry_id/edit", :controller => "notebook_entries", :action => "edit")
  patch("/notebook/:notebook_entry_id", :controller => "notebook_entries", :action => "update")
  post("/create_notebook_entry", :controller => "notebook_entries", :action => "create")
  delete("/notebook/:notebook_entry_id", :controller => "notebook_entries", :action => "destroy")


  get("/admin", { :controller => "admin", :action => "dashboard" })
  get("/admin/new_book", { :controller => "books", :action => "new_book_form" })
    
  get("/privacy_policy", { :controller => "home", :action => "privacy_policy" })
  get("/cookie_settings", { :controller => "home", :action => "cookie_settings" })

  get "/healthz", to: proc { [200, {}, ["OK"]] }

  get("/bins_and_balls", :controller => "home", :action => "bins_and_balls")

  get("/password", :controller => "passwords", :action => "index")
  post("/generate_password", {:controller => "passwords", :action => "generate_password"})

  get("/rake_tasks", { :controller => "rake_tasks", :action => "show" })
  get("/run_task", { :controller => "rake_tasks", :action => "run_task" })

end
