class PagesController < ApplicationController
    before_action :authenticate_memeber!, only: [:restricted]
    
    def home

    end

    def restricted

    end
end
