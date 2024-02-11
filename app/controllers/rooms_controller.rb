class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "施設が作成されました。"
      redirect_to room_path(@room)
    else
      session[:error_messages] = @room.errors.full_messages   
      redirect_to new_room_path
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報が更新されました。"
      redirect_to :room
    else
      session[:error_messages] = @room.errors.full_messages   
      redirect_to edit_room_path(@room)
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設が削除されました。"
    redirect_to :rooms
  end
  
  def own
    @rooms = current_user.rooms
  end

  def search
    if params[:address].present? && params[:keyword].present?
      @rooms = Room.where('address LIKE ?', "%#{params[:address]}%").where('room_name LIKE ? OR room_introduction LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    elsif params[:address].present?
      @rooms = Room.where('address LIKE ?', "%#{params[:address]}%")
    elsif params[:keyword].present?
      @rooms = Room.where('room_name LIKE ? OR room_introduction LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    else
      @rooms = Room.all
    end
  end

  private
  
  def room_params
    params.require(:room).permit(:room_name, :room_image, :room_introduction, :price, :address, :user_id)
  end
end
