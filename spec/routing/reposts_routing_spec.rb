require "spec_helper"

describe RepostsController do
  describe "routing" do

    it "routes to #index" do
      get("/reposts").should route_to("reposts#index")
    end

    it "routes to #new" do
      get("/reposts/new").should route_to("reposts#new")
    end

    it "routes to #show" do
      get("/reposts/1").should route_to("reposts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reposts/1/edit").should route_to("reposts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reposts").should route_to("reposts#create")
    end

    it "routes to #update" do
      put("/reposts/1").should route_to("reposts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reposts/1").should route_to("reposts#destroy", :id => "1")
    end

  end
end
