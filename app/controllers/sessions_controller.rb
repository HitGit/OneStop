class SessionsController < Devise::SessionsController
  def new
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end
end
