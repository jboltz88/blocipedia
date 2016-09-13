class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator successfully added"
    else
      flash[:alert] = "Error adding collaborator"
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy
    redirect_to edit_wiki_path(@wiki)
  end
end
