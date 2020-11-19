defmodule NetsEasy.Model.RefundPaymentRequest do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root request for refunding a payment.

  See https://tech.dibspayment.com/easy/api/paymentapi#refundPayment
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
