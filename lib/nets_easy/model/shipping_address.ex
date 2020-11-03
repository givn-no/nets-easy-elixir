defmodule ShippingAddress do
  @moduledoc """
  """
  @type t :: %__MODULE__{
          address_line_1: String.t(),
          address_line_2: String.t(),
          postal_code: String.t(),
          city: String.t(),
          country: String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :address_line_1,
    :address_line_2,
    :postal_code,
    :city,
    :country
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
