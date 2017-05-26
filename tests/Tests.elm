module Tests exposing (..)

import Test exposing (..)
import Expect
import Country exposing (..)


all : Test
all =
    describe "A Test Suite"
        [ test "Handles empty lists" <|
            \() ->
                let
                    pinned =
                        []

                    countries =
                        []
                in
                    Expect.equal (Country.pinAndSort pinned countries) []
        , test "Handles empty pinned list" <|
            \() ->
                let
                    pinned =
                        []

                    countries =
                        [ Country "us" "United States"
                        , Country "ca" "Canada"
                        ]

                    sortedCountries =
                        [ Country "ca" "Canada"
                        , Country "us" "United States"
                        ]
                in
                    Expect.equal (Country.pinAndSort pinned countries) sortedCountries
        , test "Handles single pinned element" <|
            \() ->
                let
                    pinned =
                        [ "mx" ]

                    countries =
                        [ Country "us" "United States"
                        , Country "mx" "Mexico"
                        , Country "ca" "Canada"
                        ]

                    sortedCountries =
                        [ Country "mx" "Mexico"
                        , Country "ca" "Canada"
                        , Country "us" "United States"
                        ]
                in
                    Expect.equal (Country.pinAndSort pinned countries) sortedCountries
        , test "Handles multiple pinned elements" <|
            \() ->
                let
                    pinned =
                        [ "us", "ca" ]

                    countries =
                        [ Country "mx" "Mexico"
                        , Country "ba" "Bahamas"
                        , Country "ca" "Canada"
                        , Country "us" "United States"
                        ]

                    sortedCountries =
                        [ Country "us" "United States"
                        , Country "ca" "Canada"
                        , Country "ba" "Bahamas"
                        , Country "mx" "Mexico"
                        ]
                in
                    Expect.equal (Country.pinAndSort pinned countries) sortedCountries
        ]
