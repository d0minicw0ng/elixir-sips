defmodule ElixirCardDeck do
  def make_deck do
    ranks = [:a, 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k]
    suits = [:spades, :clubs, :diamonds, :hearts]
    for rank <- ranks, suit <- suits, do: {:card, rank, suit}
  end
end
