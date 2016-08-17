class RoomsController < ApplicationController
  def show
    @messages = Message.all.includes(:user)
    @active = @messages.where(updated_at: (5.minutes.ago..Time.now)).map(&:user).uniq
  end
end
