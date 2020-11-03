defmodule NetsEasy.Model.GetOrderResponse.Refunds do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .refunds
  """
  @type t :: %__MODULE__{
          amount: Integer.t(),
          last_updated: String.t(),
          order_items: [Model.OrderItem.t()],
          refund_id: String.t(),
          state: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :amount,
    :last_updated,
    :order_items,
    :refund_id,
    :state
  ]

  @doc false
  def shell() do
    %__MODULE__{
      order_items: [Model.OrderItem.shell()]
    }
  end
end
