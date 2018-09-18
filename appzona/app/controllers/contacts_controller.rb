class ContactsController < ApplicationController
  def new
	  	@contact = Contact.new
	  end

	  def create
	  	@contact = Contact.new(params[:contact])
	  	@contact.request = request
	  	if @contact.deliver
			flash.now[:notice] = 'Su mensaje se envió correctamente.'
	  	else
	  		flash.now[:error] = 'Hay errores de validación en el formulario. Por favor, corríjalos y vuelva a intentarlo.'
	  		render :new
	  	end
	end
end