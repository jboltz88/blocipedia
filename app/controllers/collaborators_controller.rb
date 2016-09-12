class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:id])
    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator successfully added"
    else
      flash[:alert] = "Error adding collaborator"
    end
    redirect_to edit_wiki_path(@wiki)
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
