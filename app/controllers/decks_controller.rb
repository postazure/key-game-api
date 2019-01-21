class DecksController < ApplicationController
  def index
    decks = Deck.all
    render json: {
        decks: decks,
        count: decks.count
    }
  end

  def create
    deck = Deck.find_or_create_by(deck_params)
    render json: deck
  end

  def show
    render json: Deck.find_by_qr_code(params[:qr_code])
  end

  private

  def deck_params
    params.require(:deck).permit(:uuid, :name, :qr_code)
  end
end