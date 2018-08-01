class ContactsController < ApplicationController
  def new
	  	@contact = Contact.new
	  end

	  def create
	  	@contact = Contact.new(params[:contact])
	  	@contact.request = request
	  	if @contact.deliver

	  	else
	  		flash.noew[:error] = 'No fue posible enviar su correo.'
	  		render :new
	  	end
	end
end