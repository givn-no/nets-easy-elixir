defmodule NetsEasy.Model.GetOrderResponse.Payment do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .payment
  """
  @type t :: %__MODULE__{
          charges: [Model.GetOrderResponse.Charge.t()],
          checkout: Model.GetOrderResponse.Checkout.t(),
          consumer: Model.GetOrderResponse.Consumer.t(),
          created: String.t(),
          order_details: Model.GetOrderResponse.OrderDetails.t(),
          payment_details: Model.GetOrderResponse.PaymentDetails.t(),
          payment_id: String.t(),
          refunds: [Model.GetOrderResponse.Refunds.t()],
          summary: Model.GetOrderResponse.Summary.t(),
          subscription: Model.GetOrderResponse.Subscription.t()
        }

  @derive Poison.Encoder
  defstruct [
    :charges,
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
      charges: [Model.GetOrderResponse.Charge.shell()],
      checkout: Model.GetOrderResponse.Checkout.shell(),
      consumer: Model.GetOrderResponse.Consumer.shell(),
      order_details: Model.GetOrderResponse.OrderDetails.shell(),
      payment_details: Model.GetOrderResponse.PaymentDetails.shell(),
      refunds: [Model.GetOrderResponse.Refunds.shell()],
      summary: Model.GetOrderResponse.Summary.shell(),
      subscription: Model.GetOrderResponse.Subscription.shell()
    }
  end
end
