class ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id
    if @reservation.invalid?     
      render 'rooms/show'
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id
    if params[:back] || !@reservation.save
      render 'rooms/show'
    else
      flash[:notice] = "施設の予約が完了しました。"
      redirect_to :reservations
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "施設の予約情報を削除しました。"
    redirect_to :reservations
  end



  private
  
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :person_num, :user_id, :room_id)
  end
end
