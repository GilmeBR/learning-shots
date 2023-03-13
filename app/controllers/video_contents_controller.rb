class VideoContentsController < ApplicationController
  before_action :set_video_content, only: [:show, :edit, :update, :destroy]

  def index
    @video_contents = VideoContent.all
  end

  def show
  end

  def new
    @video_content = VideoContent.new
  end

  def edit
  end

  def create
    @video_content = VideoContent.new(video_content_params)
    @video_content.trail = Trail.find(params[:trail_id])
    respond_to do |format|
      if @video_content.save
        format.html { redirect_to @video_content, notice: 'o conteudo do video foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @video_content }
      else
        format.html { render :new }
        format.json { render json: @video_content.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @video_content.update(video_content_params)
        format.html { redirect_to @video_content, notice: '.' }
        format.json { render :show, status: :ok, location: @video_content }
      else
        format.html { render :edit }
        format.json { render json: @video_content.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video_content.destroy
    respond_to do |format|
      format.html { redirect_to video_contents_url, notice: 'V.' }
      format.json { head :no_content }
    end
  end

  private

  def set_video_content
    @video_content = VideoContent.find(params[:id])
  end

  def video_content_params
    params.require(:video_content).permit(:video_id, :title, :thumb_url, :trail_id, :description)
  end
end
