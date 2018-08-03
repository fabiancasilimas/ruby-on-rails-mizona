class WebController < ApplicationController
  def index
	def username
  	return self.current_user.email.split('@')[0].capitalize
  end
end
end
