module Country exposing (..)

import Dict


type alias Country =
    { code : String
    , display : String
    }


extractPinned : List String -> List Country -> List Country
extractPinned pinnedCountries countries =
    let
        countryDict =
            countries
                |> List.map (\country -> ( country.code, country ))
                |> Dict.fromList
    in
        pinnedCountries
            |> List.map (\name -> Dict.get name countryDict)
            |> List.filter (\country -> country /= Nothing)
            |> List.map
                (\country -> Maybe.withDefault (Country "" "") country)


extractUnpinned : List String -> List Country -> List Country
extractUnpinned pinnedCountries countries =
    countries
        |> List.filter
            (\country -> not (List.member country.code pinnedCountries))
        |> List.sortBy .display


pinAndSort : List String -> List Country -> List Country
pinAndSort pinnedCountries countries =
    extractPinned pinnedCountries countries
        ++ extractUnpinned pinnedCountries countries
