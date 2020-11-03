defmodule NetsEasy.Model.GetOrderResponse do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root response for getting an order.

  See https: //tech.dibspayment.com/easy/api/paymentapi
  """
  @type t :: %__MODULE__{
          checkout: Model.GetOrderResponse.Checkout.t(),
          consumer: Model.GetOrderResponse.Consumer.t(),
          created: String.t(),
          order_details: Model.GetOrderResponse.OrderDetails.t(),
          payment_details: Model.GetOrderResponse.PaymentDetails.t(),
          payment_id: String.t(),
          refunds: Model.GetOrderResponse.Refunds.t(),
          summary: Model.GetOrderResponse.Summary.t(),
          subscription: Model.GetOrderResponse.Subscription.t()
        }

  @derive Poison.Encoder
  defstruct [
    :checkout,
    :consumer,
    :created,
    :order_details,
    :payment_details,
    :payment_id,
    :refunds,
    :summary,
    :subscription
  ]

  @doc false
  def shell() do
    %__MODULE__{
      checkout: Model.GetOrderResponse.Checkout.shell(),
      consumer: Model.GetOrderResponse.Consumer.shell(),
      order_details: Model.GetOrderResponse.OrderDetails.shell(),
      payment_details: Model.GetOrderResponse.PaymentDetails.shell(),
      refunds: Model.GetOrderResponse.Refunds.shell(),
      summary: Model.GetOrderResponse.Summary.shell(),
      subscription: Model.GetOrderResponse.Subscription.shell()
    }
  end
end
