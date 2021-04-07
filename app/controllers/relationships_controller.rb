class RelationshipsController < ApplicationController
  before_action :authenticate_user!
def follow
	user = User.find(params[:id])
  current_user.follow(user.id)
  redirect_to request.referer

end

def unfollow
  current_user.unfollow(params[:id])
  redirect_to request.referer

end
end
