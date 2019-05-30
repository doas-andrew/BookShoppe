module SessionsHelper
    def login(user)
        session[:user_id] = user.id
    end
    
    def logout
        session.delete(:user_id)
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def user_signed_in?
        !current_user.nil?
    end

    def redirect_if_not_logged_in
        redirect_to root_path if !user_signed_in?
    end
    
    def render_403
        render(file: 'public/403', status: 403, layout: false)
    end
end
