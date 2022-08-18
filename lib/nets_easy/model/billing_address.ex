defmodule NetsEasy.Model.BillingAddress do
  @moduledoc """
  """
  @type t :: %__MODULE__{
          address_line1: String.t(),
          address_line2: String.t(),
          city: String.t(),
          country: String.t(),
          postal_code: String.t(),
          receiver_line: String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :address_line1,
    :address_line2,
    :country,
    :postal_code,
    :city,
    :receiver_line
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
