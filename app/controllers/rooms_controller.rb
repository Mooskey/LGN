class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @active = []
    msgs = Message.where(updated_at: (5.minutes.ago..Time.now))
    if msgs
      msgs.select(:user_id).distinct.each do |recent|
        @active << User.where(id: recent.user_id)
      end
    end
  end
end
# TODO: paginate/limit messages show
