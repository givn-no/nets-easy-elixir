defmodule NetsEasy.Model.GetOrderResponse.CardDetails do
  @moduledoc """
  """

  @typedoc """
  .payment_details.card_details
  """
  @type t :: %__MODULE__{
          masked_pan: String.t(),
          expiry_date: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :masked_pan,
    :expiry_date
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
