defmodule NetsEasy.Model.RefundPaymentResponse do
  @moduledoc """
  """

  @typedoc """
  Root response for refunding a payment.

  See https://tech.dibspayment.com/easy/api/paymentapi#refundPayment
  """
  @type t :: %__MODULE__{
          refund_id: String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :refund_id
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
