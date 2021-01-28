defmodule NetsEasy.Model.ChargePaymentRequest do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root request for charging a payment.

  See https://tech.dibspayment.com/easy/api/paymentapi#chargePayment
  """
  @type t :: %__MODULE__{
          amount: Integer.t(),
          order_items: [Model.OrderItem.t()]
        }
  @derive Poison.Encoder
  defstruct [
    :amount,
    :order_items
  ]
end
