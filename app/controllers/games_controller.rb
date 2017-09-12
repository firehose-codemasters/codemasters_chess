class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show; end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit; end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    @piece = @game.pieces.at(params[:piece_x].to_i, params[:piece_y].to_i).first
    unless @piece
      flash[:alert] = 'There is no piece on that square!'
      redirect_to @game
      return
    end
    to_y = params[:destination_y].to_i
    to_x = params[:destination_x].to_i

    # # The update method will change the x_position and y_position of a piece in the database.
    # # This checks if the move is valid by using the #move_tests method in the model
    if @piece.secondary_move_tests(to_x: to_x, to_y: to_y)
      @game.pieces.at(to_x, to_y).kill if @piece.move_result(to_x: to_x, to_y: to_y) == 'kill'
      @piece.update_attributes(x_position: to_x, y_position: to_y)
      @game.next_turn
    else
      flash[:alert] = 'That is an invalid move.'
    end
    redirect_to @game
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:name, :result, :white_player_id, :black_player_id)
  end
end
