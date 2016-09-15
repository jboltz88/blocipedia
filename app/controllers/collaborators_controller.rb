class CollaboratorsController < ApplicationController
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = User.all_except(current_user)
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator successfully added"
    else
      flash[:alert] = "Error adding collaborator"
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator successfully removed"
    else
      flash[:alert] = "Error removing collaborator"
    end
    redirect_to wiki_collaborators_path(@wiki)
  end
end
