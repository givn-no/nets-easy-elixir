defmodule Model.GetOrderResponse do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root response for getting an order.

  See https: //tech.dibspayment.com/easy/api/paymentapi
  """
  @type t :: %__MODULE__{
          checkout: Checkout.t(),
          consumer: Consumer.t(),
          created: String.t(),
          order_details: OrderDetails.t(),
          payment_details: PaymentDetails.t(),
          payment_id: String.t(),
          refunds: Refunds.t(),
          summary: Summary.t(),
          subscription: Subscription.t()
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
      checkout: Checkout.shell(),
      consumer: Consumer.shell(),
      order_details: OrderDetails.shell(),
      payment_details: PaymentDetails.shell(),
      refunds: Refunds.t(),
      summary: Summary.t(),
      subscription: Subscription.t()
    }
  end

  defmodule Checkout do
    @moduledoc """
    """

    @typedoc """
    .checkout
    """
    @type t :: %__MODULE__{
            url: String.t()
          }

    @derive Poison.Encoder
    defstruct [
      :url
    ]

    @doc false
    def shell(), do: %__MODULE__{}
  end

  defmodule Consumer do
    @moduledoc """
    """

    @typedoc """
    .consumer
    """
    @type t :: %__MODULE__{
            shipping_address: Model.ShippingAddress.t(),
            company: Company.t(),
            private_person: PrivatePerson.t()
          }

    @derive Poison.Encoder
    defstruct [
      :shipping_address,
      :company,
      :private_person
    ]

    @doc false
    def shell() do
      %__MODULE__{
        shipping_address: Model.ShippingAddress.shell(),
        company: Company.shell(),
        private_person: PrivatePerson.shell()
      }
    end

    defmodule Company do
      @moduledoc """
      """

      @typedoc """
      .consumer.company
      """
      @type t :: %__MODULE__{
              merchant_reference: String.t(),
              name: String.t(),
              registration_number: String.t(),
              contact_details: ContactDetails.t()
            }

      @derive Poison.Encoder
      defstruct [
        :merchant_reference,
        :name,
        :registration_number,
        :contact_details
      ]

      @doc false
      def shell() do
        %__MODULE__{
          contact_details: ContactDetails.shell()
        }
      end

      defmodule ContactDetails do
        @moduledoc """
        """

        @typedoc """
        .consumer.company.contact_details
        """
        @type t :: %__MODULE__{
                first_name: String.t(),
                last_name: String.t(),
                email: String.t(),
                phone_number: Model.PhoneNumber.t()
              }

        @derive Poison.Encoder
        defstruct [
          :first_name,
          :last_name,
          :email,
          :phone_number
        ]

        @doc false
        def shell() do
          %__MODULE__{
            phone_number: Model.PhoneNumber.shell()
          }
        end
      end
    end

    defmodule PrivatePerson do
      @moduledoc """
      """

      @typedoc """
      .consumer.private_person
      """
      @type t :: %__MODULE__{
              merchant_reference: String.t(),
              date_of_birth: String.t(),
              first_name: String.t(),
              last_name: String.t(),
              email: String.t(),
              phone_number: Model.PhoneNumber.t()
            }

      @derive Poison.Encoder
      defstruct [
        :merchant_reference,
        :date_of_birth,
        :first_name,
        :last_name,
        :email,
        :phone_number
      ]

      @doc false
      def shell() do
        %__MODULE__{
          phone_number: Model.PhoneNumber.shell()
        }
      end
    end
  end

  defmodule OrderDetails do
    @moduledoc """
    """

    @typedoc """
    .order_details
    """
    @type t :: %__MODULE__{
            amount: String.t(),
            currency: String.t(),
            reference: String.t()
          }

    @derive Poison.Encoder
    defstruct [
      :amount,
      :currency,
      :reference
    ]

    @doc false
    def shell(), do: %__MODULE__{}
  end

  defmodule PaymentDetails do
    @moduledoc """
    """

    @typedoc """
    .payment_details
    """
    @type t :: %__MODULE__{
            card_details: CardDetails.t(),
            invoice_details: InvoiceDetails.t(),
            payment_method: String.t(),
            payment_type: String.t()
          }

    @derive Poison.Encoder
    defstruct [
      :card_details,
      :invoice_details,
      :payment_method,
      :payment_type
    ]

    @doc false
    def shell() do
      %__MODULE__{
        card_details: CardDetails.shell(),
        invoice_details: InvoiceDetails.shell()
      }
    end

    defmodule CardDetails do
      @moduledoc """
      """

      @typedoc """
      .payment_details.card_details
      """
      @type t :: %__MODULE__{
              masked_pan: String.t(),
              expiry_date: String.t()
            }

      @derive Poison.Encoder
      defstruct [
        :masked_pan,
        :expiry_date
      ]

      @doc false
      def shell(), do: %__MODULE__{}
    end

    defmodule InvoiceDetails do
      @moduledoc """
      """

      @typedoc """
      .invoice_details.invoice_details
      """
      @type t :: %__MODULE__{
              due_date: String.t(),
              invoice_number: String.t(),
              ocr: String.t(),
              pdf_link: String.t()
            }

      @derive Poison.Encoder
      defstruct [
        :due_date,
        :invoice_number,
        :ocr,
        :pdf_link
      ]

      @doc false
      def shell(), do: %__MODULE__{}
    end
  end

  defmodule Refunds do
    @moduledoc """
    """

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

  defmodule Summary do
    @moduledoc """
    """

    @typedoc """
    .summary
    """
    @type t :: %__MODULE__{
            cancelled_amount: Integer.t(),
            charged_amount: Integer.t(),
            refunded_amount: Integer.t(),
            reserved_amount: Integer.t()
          }

    @derive Poison.Encoder
    defstruct [
      :cancelled_amount,
      :charged_amount,
      :refunded_amount,
      :reserved_amount
    ]

    @doc false
    def shell() do
      %__MODULE__{}
    end
  end

  defmodule Subscription do
    @moduledoc """
    """

    @typedoc """
    .subscription
    """
    @type t :: %__MODULE__{
            id: String.t()
          }

    @derive Poison.Encoder
    defstruct [
      :id
    ]

    @doc false
    def shell() do
      %__MODULE__{}
    end
  end
end
