class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show update destroy ]

  #GET /Tags
  def index
    if params[:q].present?
      @tags = Tag.starting_with(params[:q])
    else
      @tags = Tag.all
    end
  end

  #POST /Tags
  def create
    @tag = Tag.new(tag_params)
    @tag.save!
    render action: :show, status: :created
  end

  #GET /Tags/:id
  def show
  end

  #PUT/PATCH /Tags/:id
  def update
    if @tag.update(tag_params)
      render action: :show, status: :ok
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  #DELETE /Tags/:id
  def destroy
    @tag.destroy
    head :no_content
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end

end