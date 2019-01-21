class DecksController < ApplicationController
  before_action :authenticate_user!

  def index
    decks = Deck.all
    render json: {
        decks: decks.as_json(except: :added_by),
        count: decks.count
    }
  end

  def create
    deck = Deck.create_with(added_by: current_user).find_or_create_by(deck_params)
    render json: deck.as_json(except: :added_by), status: :created
  end

  def show
    deck = Deck.find_by_qr_code(params[:id]).as_json(except: :added_by)
    if deck.present?
      render json: deck
    else
      head :not_found
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:uuid, :name, :qr_code)
  end
end