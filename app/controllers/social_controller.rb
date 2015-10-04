require 'gcm'
class SocialController < ApplicationController
    def create
        @user = User.find_by_email(params[:userid])
        friends = params[:friendsid].split(',')
        begin
            friends.each do |friend|
                @friend = User.find_by_email friend
                @friend.follow @user
                @friend.save
                render json: "correct", status: 200
            end
        rescue ActiveRecord::RecordInvalid => invalid
            render json: "error", status: 500
        end
    end

    def notify
        gcm = GCM.new("AIzaSyDGmpW2dJOFPOQy878EjpVjoEWuFNT9aG4")
        users = User.all
        registration_id = []
        users.each do |user|
            registration_id.push user.gcm
        end
        puts registration_id
        data = `ruby ~/defg.rb`
        options={:data => {:title => "Some message",:body=> data }}
        puts options
        response = gcm.send(registration_id, options)
        puts response
    end

    def delete
    end

    def index
        @user = User.find_by_email(params[:userid])
        @friends = @user.follows
        dick = {}
        @friends.each do |friend|
            dick[friend.follower.email] = avatar_url friend.follower
        end
        render json: dick
    end
    def avatar_url(user)
        default_url = "#{root_url}/assets/guest.png"
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
end
