defmodule GetOrderTest do
  use ExUnit.Case
  import Tesla.Mock
  require Logger

  # straight from the documentation
  @response_body json(%{
                   "checkout" => %{
                     "url" => "string"
                   },
                   "consumer" => %{
                     "shippingAddress" => %{
                       "addressLine1" => "string",
                       "addressLine2" => "string",
                       "receiverLine" => "string",
                       "postalCode" => "string",
                       "city" => "string",
                       "country" => "string"
                     },
                     "company" => %{
                       "merchantReference" => "string",
                       "name" => "string",
                       "registrationNumber" => "string",
                       "contactDetails" => %{
                         "firstName" => "string",
                         "lastName" => "string",
                         "email" => "string",
                         "phoneNumber" => %{
                           "prefix" => "string",
                           "number" => "string"
                         }
                       }
                     },
                     "privatePerson" => %{
                       "merchantReference" => "string",
                       "dateOfBirth" => "2020-01-22T10:56:51.236Z",
                       "firstName" => "string",
                       "lastName" => "string",
                       "email" => "string",
                       "phoneNumber" => %{
                         "prefix" => "string",
                         "number" => "string"
                       }
                     }
                   },
                   "created" => "2017-03-22T08:02:30.977Z",
                   "orderDetails" => %{
                     "amount" => "string",
                     "currency" => "string",
                     "reference" => "string"
                   },
                   "paymentDetails" => %{
                     "cardDetails" => %{
                       "maskedPan" => "string",
                       "expiryDate" => "string"
                     },
                     "invoiceDetails" => %{
                       "dueDate" => "string",
                       "invoiceNumber" => "string",
                       "ocr" => "string",
                       "pdfLink" => "string"
                     },
                     "paymentMethod" => "string",
                     "paymentType" => "string"
                   },
                   "paymentId" => "string",
                   "refunds" => %{
                     "amount" => 0,
                     "lastUpdated" => "string",
                     "orderItems" => [
                       %{
                         "reference" => "ex125454",
                         "name" => "example name",
                         "quantity" => 10,
                         "unit" => "pcs",
                         "unitPrice" => 100,
                         "taxRate" => 2500,
                         "taxAmount" => 250,
                         "grossTotalAmount" => 1250,
                         "netTotalAmount" => 1000
                       }
                     ],
                     "refundId" => "string",
                     "state" => "string"
                   },
                   "summary" => %{
                     "cancelledAmount" => 0,
                     "chargedAmount" => 0,
                     "refundedAmount" => 0,
                     "reservedAmount" => 0
                   },
                   "subscription" => %{
                     "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6"
                   }
                 })

  test "GET /v1/payments" do
    client = Client.create_client()

    mock(fn
      %{method: :get, url: "http://bears.gov/v1/payments/string"} ->
        @response_body
    end)

    resp = NetsEasy.Api.get_payment_order(client, "string")

    {:ok,
     %NetsEasy.Model.GetOrderResponse{
       checkout: checkout,
       consumer: consumer,
       order_details: order_details,
       payment_details: payment_details,
       refunds: refunds,
       summary: summary,
       subscription: subscription
     }} = resp

    assert checkout.url == "string"
    assert consumer.shipping_address.city == "string"
    assert consumer.company.contact_details.phone_number.number == "string"
    assert consumer.private_person.phone_number.number == "string"
    assert order_details.reference == "string"
    assert payment_details.card_details.expiry_date == "string"
    assert payment_details.invoice_details.ocr == "string"
    assert hd(refunds.order_items).reference == "ex125454"
    assert summary.reserved_amount == 0
    assert subscription.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  end
end
