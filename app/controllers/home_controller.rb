require 'meetup_client'
class HomeController < ApplicationController
    def index
    end


    def gcm
        begin
            @user = User.find_by_email params[:userid]
            @user.gcm = params[:gcm]
            @user.save
            render json: @user ,status: 200
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
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
            @abcd = JSON.parse(`ruby ~/abcd.rb`).to_json
            render json: @abcd ,status: 200
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
    end
    def meetup
        MeetupClient.configure do |config|
            config.api_key = "a7e1164a781c565d4731425134"
        end
        begin
            @user = User.find_by_email(params[:userid])
            params = { category: '1',
                       city: 'Hanover',
                       state: 'NH',
                       country: 'US',
                       radius: 100,
                       lat: @user.latitude.to_f,
                       lon: @user.longitude.to_f,
                       status: 'upcoming',
                       format: 'json',
                       page: '50'}
            meetup_api = MeetupApi.new
            events = meetup_api.open_events(params)
            puts events
            render json: events,status: 200
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
    end
end
