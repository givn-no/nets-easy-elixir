defmodule NetsEasy.Model.OrderItem do
  @moduledoc """
  """

  @typedoc """
  """
  @type t :: %__MODULE__{
          reference: String.t() | nil,
          name: String.t(),
          quantity: Integer.t(),
          unit: String.t(),
          unit_price: Integer.t(),
          tax_rate: Integer.t(),
          tax_amount: Integer.t(),
          gross_total_amount: Integer.t(),
          net_total_amount: Integer.t()
        }

  @derive Poison.Encoder
  defstruct [
    :reference,
    :name,
    :quantity,
    :unit,
    :unit_price,
    :tax_rate,
    :tax_amount,
    :gross_total_amount,
    :net_total_amount
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
