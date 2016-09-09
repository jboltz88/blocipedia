class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def downgrade_account
    current_user.standard!
    current_user.wikis.update_all(private: false)
    flash["notice"] = "Your account has been downgraded"
    redirect_to edit_user_registration_path
  end
end
