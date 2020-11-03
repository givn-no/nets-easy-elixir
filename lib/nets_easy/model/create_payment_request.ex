defmodule NetsEasy.Model.CreatePaymentRequest do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root request for creating a payment request.

  See https: //tech.dibspayment.com/easy/api/paymentapi
  """
  @type t :: %__MODULE__{
          order: Order.t(),
          merchant_number: Integer.t() | nil,
          checkout: Checkout.t(),
          notifications: Notifications.t() | nil,
          payment_methods: [PaymentMethod.t()] | nil
        }
  @derive Poison.Encoder
  defstruct [
    :order,
    :merchant_number,
    :checkout,
    :notifications,
    :payment_methods
  ]

  defmodule Order do
    @moduledoc """
    """

    @typedoc """
    .order
    """
    @type t :: %__MODULE__{
            items: [Model.OrderItem.t()],
            amount: Integer.t(),
            currency: Currency.t(),
            reference: String.t()
          }
    @derive Poison.Encoder
    defstruct [
      :items,
      :amount,
      :currency,
      :reference
    ]

    defmodule Currency do
      @type t :: :NOK

      @doc false
      def from_string(currency) do
        case String.downcase(currency) do
          "nok" -> :NOK
          _ -> raise "invalid currency code #{currency}"
        end
      end
    end
  end

  defmodule Checkout do
    @moduledoc """
    """

    @typedoc """
    .checkout
    """
    @type t :: %__MODULE__{
            charge: boolean() | nil,
            public_device: boolean() | nil,
            integration_type: integration_type() | nil,
            url: String.t() | nil,
            return_url: String.t() | nil,
            terms_url: String.t(),
            appearance: Appearance.t() | nil,
            merchant_handles_consumer_data: boolean() | nil,
            consumer: Consumer.t() | nil,
            consumer_type: ConsumerType.t(),
            merchant_handles_shipping_cost: boolean(),
            shipping: Shipping.t() | nil
          }
    @derive Poison.Encoder
    defstruct [
      :charge,
      :public_device,
      :integration_type,
      :url,
      :return_url,
      :terms_url,
      :appearance,
      :merchant_handles_consumer_data,
      :consumer,
      :consumer_type,
      :merchant_handles_shipping_cost,
      :shipping
    ]

    # is this correct? seems weird
    @type integration_type :: :EmbeddedCheckout | :hostedPaymentPage

    defmodule Appearance do
      @moduledoc """
      """

      @typedoc """
      .checkout.appearance
      """
      @type t :: %__MODULE__{
              display_options: DisplayOptions.t() | nil,
              text_options: TextOptions.t() | nil
            }
      @derive Poison.Encoder
      defstruct [
        :display_options,
        :text_options
      ]

      defmodule DisplayOptions do
        @moduledoc """
        """

        @typedoc """
        .checkout.appearance.display_options
        """
        @type t :: %__MODULE__{
                show_merchant_name: boolean() | nil,
                show_order_summary: boolean() | nil
              }
        @derive Poison.Encoder
        defstruct [
          :show_merchant_name,
          :show_order_summary
        ]
      end

      defmodule TextOptions do
        @moduledoc """
        """

        @typedoc """
        .checkout.appearance.text_options
        """
        @type t :: %__MODULE__{
                complete_payment_button_text: String.t()
              }
        @derive Poison.Encoder
        defstruct [
          :complete_payment_button_text
        ]
      end
    end

    defmodule Consumer do
      @moduledoc """
      """

      @typedoc """
      .checkout.consumer
      """
      @type t :: %__MODULE__{
              reference: String.t(),
              email: String.t(),
              shipping_address: Model.ShippingAddress.t(),
              phone_number: Model.PhoneNumber.t(),
              private_person: PrivatePerson.t() | nil,
              company: Company.t() | nil
            }
      @derive Poison.Encoder
      defstruct [
        :reference,
        :email,
        :shipping_address,
        :phone_number,
        :private_person,
        :company
      ]

      defmodule PrivatePerson do
        @moduledoc """
        """

        @typedoc """
        .checkout.consumer.private_person
        """
        @type t :: %__MODULE__{
                first_name: String.t(),
                last_name: String.t()
              }
        @derive Poison.Encoder
        defstruct [
          :first_name,
          :last_name
        ]
      end

      defmodule Company do
        @moduledoc """
        """

        @typedoc """
        .checkout.consumer.company
        """
        @type t :: %__MODULE__{
                name: String.t(),
                contact: Contact.t()
              }
        @derive Poison.Encoder
        defstruct [
          :name,
          :contact
        ]

        defmodule Contact do
          @moduledoc """
          """

          @typedoc """
          .checkout.consumer.company.contact
          """
          @type t :: %__MODULE__{
                  first_name: String.t(),
                  last_name: String.t()
                }
          @derive Poison.Encoder
          defstruct [
            :first_name,
            :last_name
          ]
        end
      end
    end

    defmodule ConsumerType do
      @moduledoc """
      """

      @typedoc """
      .checkout.consumer_type
      """
      @type t :: %__MODULE__{
              default: consumer_type,
              supported_types: [consumer_type]
            }

      @type consumer_type :: :B2C | :B2B

      @derive Poison.Encoder
      defstruct [
        :default,
        :supported_types
      ]
    end

    defmodule Shipping do
      @moduledoc """
      """

      @typedoc """
      .checkout.shipping
      """
      @type t :: %__MODULE__{
              countries: [CountryCode.t()]
            }
      @derive Poison.Encoder
      defstruct [
        :countries
      ]

      defmodule CountryCode do
        # TODO: add more here
        @type t :: :NO | :SWE | :DK
      end
    end
  end

  defmodule Notifications do
    @moduledoc """
    """

    @typedoc """
    .notifications
    """
    @type t :: %__MODULE__{
            web_hooks: [WebHook.t()]
          }
    @derive Poison.Encoder
    defstruct [
      :web_hooks
    ]

    defmodule WebHook do
      @type t :: %__MODULE__{
              event_name: String.t(),
              url: String.t(),
              authorization: String.t()
            }
      @derive Poison.Encoder
      defstruct [
        :event_name,
        :url,
        :authorization
      ]
    end
  end

  defmodule PaymentMethod do
    @moduledoc """
    Used for setting fees for invoice payments, only works for invoice payments.

    I don't think name can be anything other than 'easyinvoice'
    """

    @typedoc """
    .payment_method
    """
    @type t :: %__MODULE__{
            name: String.t(),
            fee: Fee.t()
          }
    @derive Poison.Decoder
    defstruct [
      :name,
      :fee
    ]

    defmodule Fee do
      @moduledoc """
      """

      @typedoc """
      .payment_method.fee
      """
      @type t :: %__MODULE__{
              reference: String.t(),
              name: String.t(),
              quantity: Integer.t(),
              unit: String.t(),
              unit_price: Integer.t(),
              tax_rate: Integer.t(),
              tax_amount: Integer.t(),
              gross_total_amount: Integer.t(),
              net_total_amount: Integer.t()
            }
      @derive Poison.Decoder
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
    end
  end
end
