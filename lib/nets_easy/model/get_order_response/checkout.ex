defmodule NetsEasy.Model.GetOrderResponse.Checkout do
  @moduledoc """
  """

  @typedoc """
  .checkout
  """
  @type t :: %__MODULE__{
          url: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :url
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
