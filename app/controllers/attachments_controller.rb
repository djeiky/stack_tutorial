class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment
  
  def destroy
    if current_user && current_user.author_of?(@attachment.attachable)
      @attachment.destroy
    else
      flush[:notice] = "You are not author"
    end
  end

  private

    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

end

