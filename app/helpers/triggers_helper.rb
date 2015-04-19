module TriggersHelper
    def correct_trigger_user
        temp = Trigger.find(params[:id])
        user_for_trigger = temp.userEmail
        if User.exists?(:email1 => user_for_trigger)
            @user = User.find_by(:email1 => user_for_trigger)
            redirect_to homepage_url, notice: 'User is not the correct user' unless current_user?(@user)
            else
            redirect_to homepage_url, notice: 'User does not exist'
        end
    end
end
