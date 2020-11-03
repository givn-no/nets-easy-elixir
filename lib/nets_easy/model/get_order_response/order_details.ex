defmodule NetsEasy.Model.GetOrderResponse.OrderDetails do
  @moduledoc """
  """

  @typedoc """
  .order_details
  """
  @type t :: %__MODULE__{
          amount: String.t(),
          currency: String.t(),
          reference: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :amount,
    :currency,
    :reference
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end

defimpl Poison.Decoder,
  for: NetsEasy.Model.CreatePaymentRequest.OrderDetails do
  def decode(%{currency: currency} = order_details, _) do
    %{
      order_details
      | currency: NetsEasy.Model.Currency.from_string(currency)
    }
  end
end
