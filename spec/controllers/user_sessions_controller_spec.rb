require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  integrate_views
  
  describe "#create" do
    context "upgrading login methods" do
      before do
        @password = "testing"
        @crypted  = "abb3ece8fed2c4bc9f64d8291ff3c9628003fc83"
        @salt     = "0a10643de48fa9bb8dc167fe04f2405ee8b21019"
        
        @user                  = User.make(:login => "user123")
        @user.crypted_password = @crypted
        @user.password_salt    = @salt
        @user.save!
        
        @params = {"user_session" => 
                    {"login"      => @user.login, 
                     "password"   => @password}}

        post :create, @params
      end
    
      it "logs in successfully" do
        response.location.should == root_url
      end
    
      it "changes the crypted_password" do
        user = User.find(@user.id)
        user.crypted_password.should_not == @crypted
      end
      
      it "logs in successfully after password has been updated" do
        post :destroy
        post :create, @params # second login

        response.location.should == root_url
      end
    end
  end
end
