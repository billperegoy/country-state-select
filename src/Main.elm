module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Country exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { name : String }


init : ( Model, Cmd Msg )
init =
    Model "world" ! []


pinnedCountryList : List String
pinnedCountryList =
    [ "us", "ca", "mx" ]


countryList : List Country
countryList =
    [ Country "fr" "France"
    , Country "mx" "Mexico"
    , Country "ba" "Bahamas"
    , Country "ca" "Canada"
    , Country "us" "United States"
    ]



-- Update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []



-- View


selectOptions : List Country -> List String -> List (Html Msg)
selectOptions countries pinned =
    countries
        |> Country.pinAndSort pinned
        |> List.map (\country -> option [ value country.code ] [ text country.display ])


view : Model -> Html Msg
view model =
    div []
        [ select [] (selectOptions countryList pinnedCountryList)
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
