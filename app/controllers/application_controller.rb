class ApplicationController < ActionController::Base
    include SessionsHelper

    def render_403
    	render(file: 'public/403', status: 403, layout: false)
    end
end
