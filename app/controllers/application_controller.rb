class ApplicationController < ActionController::Base
    include SessionsHelper

    def check_403
    	render_403 if !user_signed_in?
    end

    def render_403
    	render(file: 'public/403', status: 403, layout: false)
    end
end
