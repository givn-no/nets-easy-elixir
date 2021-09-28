defmodule GetOrderTest do
  use ExUnit.Case
  import Tesla.Mock
  require Logger

  alias NetsEasy.Model
  alias NetsEasy.Model.GetOrderResponse

  # straight from the documentation
  @response_body json(%{
                   "payment" => %{
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
                     "refunds" => [
                       %{
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
                       }
                     ],
                     "summary" => %{
                       "cancelledAmount" => 0,
                       "chargedAmount" => 0,
                       "refundedAmount" => 0,
                       "reservedAmount" => 0
                     },
                     "subscription" => %{
                       "id" => "3fa85f64-5717-4562-b3fc-2c963f66afa6"
                     }
                   }
                 })

  @actual_body json(%{
                 "payment" => %{
                   "checkout" => %{
                     "url" => "https://maaemo.givn.test:4000/order/cd6dea9a-92a8-4a09-82a8-3efef40d1817"
                   },
                   "consumer" => %{
                     "company" => %{
                       "contactDetails" => %{
                         "phoneNumber" => %{}
                       }
                     },
                     "privatePerson" => %{
                       "email" => "halvor@hoopla.n",
                       "firstName" => "Halvor",
                       "lastName" => "Bjørnscaler",
                       "phoneNumber" => %{
                         "number" => "97635419",
                         "prefix" => "+47"
                       }
                     },
                     "shippingAddress" => %{
                       "addressLine1" => "Nydalsveien 18",
                       "addressLine2" => "",
                       "city" => "OSLO",
                       "country" => "NOR",
                       "postalCode" => "0570",
                       "receiverLine" => "Halvor Bjørnscaler"
                     }
                   },
                   "created" => "2020-11-03T14:17:32.3772+00:00",
                   "orderDetails" => %{
                     "amount" => 1_639_200,
                     "currency" => "NOK",
                     "reference" => "cd6dea9a-92a8-4a09-82a8-3efef40d1817"
                   },
                   "paymentDetails" => %{
                     "cardDetails" => %{
                       "expiryDate" => "1233",
                       "maskedPan" => "492500******0004"
                     },
                     "invoiceDetails" => %{},
                     "paymentMethod" => "Visa",
                     "paymentType" => "CARD"
                   },
                   "paymentId" => "006d00005fa1666f7f76b91b749703c0",
                   "summary" => %{
                     "reservedAmount" => 1_639_200
                   }
                 }
               })

  test "GET /v1/payments" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :get, url: "http://bears.gov/v1/payments/id"} ->
        @response_body
    end)

    IO.inspect("@response_body")
    IO.inspect(@response_body)
    resp = NetsEasy.Api.get_payment_order(client, "id")

    {:ok,
     %GetOrderResponse{
       payment: %GetOrderResponse.Payment{
         checkout: %GetOrderResponse.Checkout{
           url: url
         },
         consumer: %GetOrderResponse.Consumer{
           shipping_address: shipping_address,
           company: company,
           private_person: private_person
         },
         order_details: order_details,
         payment_details: payment_details,
         refunds: refunds,
         summary: summary,
         subscription: subscription
       }
     }} = resp

    assert url == "string"
    assert shipping_address.city == "string"
    assert company.contact_details.phone_number.number == "string"
    assert private_person.phone_number.number == "string"
    assert order_details.reference == "string"
    assert payment_details.card_details.expiry_date == "string"
    assert payment_details.invoice_details.ocr == "string"
    assert hd(hd(refunds).order_items).reference == "ex125454"
    assert summary.reserved_amount == 0
    assert subscription.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  end

  test "GET /v1/payments with an actual response from their apis" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :get, url: "http://bears.gov/v1/payments/id"} ->
        @actual_body
    end)

    resp = NetsEasy.Api.get_payment_order(client, "id")

    {:ok,
     %GetOrderResponse{
       payment: %GetOrderResponse.Payment{
         checkout: %GetOrderResponse.Checkout{
           url: url
         },
         consumer: %GetOrderResponse.Consumer{
           shipping_address: shipping_address,
           company: company,
           private_person: private_person
         },
         order_details: order_details,
         payment_details: payment_details,
         refunds: refunds,
         summary: summary,
         subscription: subscription
       }
     }} = resp

    assert url == "https://maaemo.givn.test:4000/order/cd6dea9a-92a8-4a09-82a8-3efef40d1817"
    assert shipping_address.city == "OSLO"
    assert company.contact_details.phone_number.number == nil
    assert private_person.phone_number.number == "97635419"
    assert order_details.reference == "cd6dea9a-92a8-4a09-82a8-3efef40d1817"
    assert payment_details.card_details.expiry_date == "1233"
    assert payment_details.invoice_details.ocr == nil
    assert refunds == nil
    assert summary.reserved_amount == 1_639_200
    assert subscription == nil
  end
end
