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
