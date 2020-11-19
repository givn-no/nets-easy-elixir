defmodule NetsEasy.Model.GetOrderResponse.Charge do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .payment.charges, undocumented.
  """
  @type t :: %__MODULE__{
          amount: Integer.t(),
          charge_id: String.t(),
          created: String.t(),
          order_items: [Model.OrderItem.t()]
        }

  @derive Poison.Encoder
  defstruct [
    :amount,
    :charge_id,
    :created,
    :order_items
  ]

  @doc false
  def shell() do
    %__MODULE__{
      order_items: [Model.OrderItem.shell()]
    }
  end
end
