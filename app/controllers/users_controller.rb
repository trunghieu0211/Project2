class UsersController < ApplicationController
  load_and_authorize_resource except: [:show]

  def show
    @user = User.find_by id: params[:id]
  end
end
