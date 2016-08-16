class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :remove_game]

    def index
      @userss = current_user.nearbys(25) || User.near("Miami", 200)

      @page = (params[:page] || 1).to_i
      skip = (@page - 1) * 10
      @users =   @userss.
                  order(created_at: :desc).
                  limit(10).
                  offset(skip).
                  all
              if params[:page] != nil && params[:page].to_i < 1
                redirect_back fallback_location: events_path

              elsif ((@userss.length/10.0).ceil && 1) < params[:page].to_i
                redirect_to "/events/page/#{(@userss.length/10.0).ceil}"
              end
    end



    def show
      @users_games = []
      @games_user_records = GamesUser.where(user_id: current_user)
      @games_user_records.each do |record|
        @users_games << Game.find(record.game_id)
      end
      @users_games
    end


    def edit
    end

    def remove_game
      @games_user_records = GamesUser.where(user_id: current_user).all
      if @user == current_user
        @games_user_records.find_by(game_id: params[:game_id]).delete
      else
        flash[:alert]= "That's not your account..."
      end
      redirect_to @user
    end

    def update
      respond_to do |format|

        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :zip, :address, :country, :state, :dob, :fb, :psn, :xbox, :steam, :twitch, :bio, :profile_img)
    end
end
