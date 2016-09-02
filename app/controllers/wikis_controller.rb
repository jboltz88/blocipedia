class WikisController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = Wiki.new
  end

  def create
    @user = current_user
    @wiki = @user.wikis.build(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was successfully saved."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error updating the Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki was successfully deleted."
      redirect_to root_path
    else
      flash[:alert] = "There was an error deleting the Wiki."
      redirect_to @wiki
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
