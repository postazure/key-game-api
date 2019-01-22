class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    games = current_user.games
    render json: {
        games: games.as_json(except: :user),
        count: games.count
    }
  end

  def create
    game = Game.new(
        win: game_params[:win],
        user: current_user,
        deck_uuid: game_params[:deck_uuid],
        opponent_deck_uuid: game_params[:opponent_deck_uuid],
        notes: game_params[:notes],
    )

    if game.save!
      render json: game.as_json(except: :added_by), status: :created
    else
      head 422
    end
  end

  private

  def game_params
    params.require(:game).permit(:opponent_deck_uuid, :deck_uuid, :notes, :win)
  end
end