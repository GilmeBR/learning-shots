class TrailsController < ApplicationController
  def index
    @trails = current_user.trails.all
  end

  def show
    @trail = Trail.find(params[:id])
    @video_content = VideoContent.new
  end

  def new
    @trail = Trail.new
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save
      redirect_to trails_path, notice: "Trail created successfully"
    else
      render :new
    end
  end

  def edit
    @trail = Trail.find(params[:id])
  end

  def update
    @trail= Trail.find(params[:id])
    if @trail.update(trail_params)
      redirect_to trail_path(@trail), notice: "Trail updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @trail = Trail.find(params[:id])
    @trail.destroy

    redirect_to trails_path, status: :see_other, notice: "Trail deleted successfully"
  end

  def search
    @results = YoutubeService.new.search_videos(params[:query])
  
  end

  private

  def trail_params
    params.require(:trail).permit(:user_id, :title, :description, :category)
  end
end
