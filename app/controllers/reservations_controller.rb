class ReservationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @reservations = current_user.reservations
  end

  def confirm
    if params[:reservation]
      @reservation = Reservation.new(reservation_params)
      @room = Room.find(params[:reservation][:room_id])
      @reservation.user_id = current_user.id
      @reservation.room_id = @room.id
      session[:reservation] = @reservation.attributes
      if @reservation.invalid?
        session[:error_messages] = @reservation.errors.full_messages   
        redirect_to room_path(@room)
      end
      
    end
    if session[:reservation]
      @reservation = Reservation.new(session[:reservation])
      @room = Room.find(params[:reservation][:room_id])
      @reservation.user_id = current_user.id
      @reservation.room_id = @room.id
    else
      @reservation = Reservation.new
    end

  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id
    if params[:back] || !@reservation.save
      redirect_to room_path(@room)
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

  def show
    @reservation = Reservation.new(session[:reservation])
    @room = Room.find(@reservation.room_id)
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id
  end
  private
  
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :person_num, :user_id, :room_id)
  end
end

















