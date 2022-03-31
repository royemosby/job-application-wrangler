class ContactsController < ApplicationController
  before_action :authenticated?
  before_action :own_contact?, only: %i[ show update destroy ]

  def index
    @contacts = @user.contacts
    render json: @contacts
  end

  def show
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = @user
    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    render json: {message: "Contact was succesfully destroyed."}
  end

  private

  #explicit bool returns since this method is evaluated in own_contact?
  def set_contact
    @contact = Contact.find_by(id: params[:id])
    if !@contact
      render json: {message: "not found"}, status: :not_found
      false
    else
      true
    end
  end

  def own_contact?
    if set_contact
      if current_user != @contact.user
        render json: {message: "You are not authorized to access contacts that you did not create"}, status: :forbidden
      end
    end
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :contact_type, :email, :url, :phone, :notes, :user_id)
  end
end
