module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Utils
import Dict


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Country =
    { code : String
    , display : String
    }


type alias Model =
    { name : String }


init : ( Model, Cmd Msg )
init =
    Model "world" ! []


pinnedCountryList : List String
pinnedCountryList =
    [ "us", "ca" ]


countryList : List Country
countryList =
    [ Country "fr" "France"
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


sortCountries : List String -> List Country -> List Country
sortCountries pinned countries =
    let
        pinnedTuple =
            pinned
                |> List.map (\code -> ( code, Nothing ))

        countryDict =
            countries
                |> List.map (\country -> ( country.code, country ))
                |> Dict.fromList

        pinnedCountries =
            pinned
                |> List.map (\name -> Dict.get name countryDict)
                |> List.map
                    (\country -> Maybe.withDefault (Country "" "") country)

        unpinnedCountries =
            countries
                |> List.filter
                    (\country -> not (List.member country.code pinnedCountryList))
                |> List.sortBy .display
    in
        pinnedCountries ++ unpinnedCountries


selectOptions : List Country -> List String -> List (Html Msg)
selectOptions countries pinned =
    countries
        |> sortCountries pinned
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
