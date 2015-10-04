class HomeController < ApplicationController
    def index
    end
    def register
        begin
            id = 0
            college = false
            if params[:collegeid]==0
                college = false
            else
                id = params[:collegeid]
                college = true
            end
            @user= User.create!(:email=>params[:userid],:password => params[:password], :password_confirmation => params[:password], :dartmouth => college,:school => id)
            if @user.valid?
                render json: @user ,status: 200
            end
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
    end
    def location
        begin
            @user = User.find_by_email(params[:userid])
            @user.latitude = params[:lat]
            @user.longitude = params[:long]
            @user.save
            render json: @user ,status: 200
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
    end
end
