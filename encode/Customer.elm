module Customer.Customer exposing (Customer, contacts, customerDecoder, fullname, lastname, name, customerEncoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, hardcoded, optional, required)
import Json.Encode as Encode exposing (Value)

type alias Customer =
    { name : String
    , lastname : String
    , email : String
    , phone : String
    }


name : Customer -> String
name customer =
    customer.name


lastname : Customer -> String
lastname customer =
    customer.lastname


fullname : Customer -> String
fullname customer =
    customer.name ++ " " ++ customer.lastname


contacts : Customer -> String
contacts customer =
    customer.email ++ "  " ++ customer.phone


customerEncoder : Customer -> List (String, Value)
customerEncoder customer =
    [ ( "name", Encode.string customer.name )
    , ( "lastname", Encode.string customer.lastname )
    , ( "phone", Encode.string customer.phone )
    , ( "email", Encode.string customer.email )
    ]
