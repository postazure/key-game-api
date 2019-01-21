class DecksController < ApplicationController
  before_action :authenticate_user!

  def index
    decks = Deck.all
    render json: {
        decks: decks,
        count: decks.count
    }
  end

  def create
    deck = Deck.find_or_create_by(deck_params)
    render json: deck, status: :created
  end

  def show
    deck = Deck.find_by_qr_code(params[:id])
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