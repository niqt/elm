module Order exposing (Form, Order(..), SubOrder, SubProduct, encodeOrder, subOrderEncode, subProductEncode)

import Customer.Customer as Customer exposing (Customer, customerDecoder)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, hardcoded, required)
import Json.Encode as Encode exposing (Value)



{-
   This is the JSON to encode
   {
   	"order":{
   	"price": 85.0,
   	"suborders": [
   		{
   			"price": 25.0,
   			"product": {"id": "1", "name": "elm"},
   			"qta": "0.19"
   		},
   		{
   			"price": 35.0,
   			"product": {"id": "55", "name": "golang"},
   			"qta": "1.12"
   		}
   		],
   	"shop":  "xyz",
   	"customer": {
   		"email": "xxx@yyyyy.com",
   		"name": "niqt",
   		"lastname": "notdefine"
   	}
   	}
   }

-}


type Order a
    = Order Internals a


type alias SubProduct =
    { id : String
    , name : String
    }


type alias SubOrder =
    { price : Float
    , qta : String
    , product : SubProduct
    }


type alias Form =
    { price : Float
    , customer : Customer
    , farmuser : String
    , suborders : List SubOrder
    }


subOrderEncode : SubOrder -> Value
subOrderEncode subOrder =
    Encode.object
        [ ( "price", Encode.float subOrder.price )
        , ( "qta", Encode.string subOrder.qta )
        , ( "product", subProductEncode subOrder.product )
        ]


subProductEncode : SubProduct -> Value
subProductEncode subProduct =
    Encode.object
        [ ( "id", Encode.string subProduct.id )
        , ( "name", Encode.string subProduct.name )
        ]


encodeOrder : Form -> Value
encodeOrder form =
    Encode.object
        [ ( "price", Encode.float form.price )
        , ( "customer", Encode.object <| Customer.customerEncoder form.customer )
        , ( "shop", Encode.string form.farmuser )
        , ( "suborders"
          , Encode.list Order.subOrderEncode form.suborders
          )
        ]
