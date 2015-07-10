class SessionsController < ApplicationController

  def create
    @account = Account.from_omniauth(env["omniauth.auth"])
    session[:account_id] = account.id
  end

  def destroy
    session[:account_id]= nil
    redirect_to root_url notice: "Signed out successfully."
  end
  
end
