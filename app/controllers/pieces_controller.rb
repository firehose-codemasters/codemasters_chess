class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy]

  # GET /pieces
  # GET /pieces.json
  def index
    @pieces = Piece.all
  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show; end

  # GET /pieces/new
  def new
    @piece = Piece.new
  end

  # GET /pieces/1/edit
  def edit; end

  # POST /pieces
  # POST /pieces.json
  def create
    @piece = Piece.new(piece_params)

    respond_to do |format|
      if @piece.save
        format.html { redirect_to @piece, notice: 'Piece was successfully created.' }
        format.json { render :show, status: :created, location: @piece }
      else
        format.html { render :new }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pieces/1
  # PATCH/PUT /pieces/1.json
  def update
    @piece = Piece.find(params[:id])
    # to_x = @piece.x_position.to_i
    # to_y = @piece.y_position.to_i
    to_y = params[:piece][:y_position].to_i
    to_x = params[:piece][:x_position].to_i

    # The update method will change the x_position and y_position of a piece in the database.
    # This checks if the move is valid by using the mvoe method in the model
    # tests = @piece.move_tests(to_x: to_x, to_y: to_y)
    # binding.pry
    @piece.update(piece_params) if @piece.move_tests(to_x: to_x, to_y: to_y)
    # respond_to do |format|
       
      #   format.html { redirect_to @piece, notice: 'Piece was successfully updated.' }
      #   format.json { render :show, status: :ok, location: @piece }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @piece.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # DELETE /pieces/1
  # DELETE /pieces/1.json
  def destroy
    @piece.destroy
    respond_to do |format|
      format.html { redirect_to pieces_url, notice: 'Piece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_piece
    @piece = Piece.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def piece_params
    params.require(:piece).permit(:color, :active, :x_position, :y_position, :type, :game_id)
  end
end
