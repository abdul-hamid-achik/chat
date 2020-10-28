module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { route : String
    , isNavbarOpen : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { route = ""
      , isNavbarOpen = False
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = OpenNavbar
    | CloseNavbar
    | LinkClicked
    | UrlChanged


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OpenNavbar ->
            ( { model | isNavbarOpen = True }, Cmd.none )

        CloseNavbar ->
            ( { model | isNavbarOpen = False }, Cmd.none )

        _ ->
            ( model, Cmd.none )


toggleNavbar : Bool -> Msg
toggleNavbar isNavbarOpen =
    case isNavbarOpen of
        False ->
            OpenNavbar

        True ->
            CloseNavbar



---- VIEW ----


view : Model -> Html Msg
view model =
    section
        [ classList
            [ ( "hero", True )
            , ( "is-success", True )
            , ( "is-fullheight", True )
            ]
        ]
        [ div [ class "hero-head" ]
            [ header [ class "navbar" ]
                [ div [ class "container" ]
                    [ div [ class "navbar-brand" ]
                        [ a [ class "navbar-item" ] [ img [ src "https://bulma.io/images/bulma-type-white.png" ] [] ]
                        , span
                            [ classList
                                [ ( "navbar-burger", True )
                                , ( "burger", True )
                                ]
                            , onClick <| toggleNavbar model.isNavbarOpen
                            ]
                            [ span [] []
                            , span [] []
                            , span [] []
                            ]
                        ]
                    , div [ classList [ ( "navbar-menu", True ), ( "is-active", model.isNavbarOpen ) ] ]
                        [ div [ class "navbar-end" ]
                            [ a
                                [ classList
                                    [ ( "navbar-item", True )
                                    , ( "is-active", True )
                                    ]
                                ]
                                [ text "Login" ]
                            , a
                                [ classList
                                    [ ( "navbar-item", True )
                                    , ( "is-active", False )
                                    ]
                                ]
                                [ text "Sign Up" ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "hero-body" ] []
        , div [ class "hero-foot" ]
            [ nav [ classList [ ( "tabs", True ), ( "is-boxed", True ), ( "is-fullwidth", True ) ] ]
                [ div [ class "container" ]
                    [ ul []
                        [ li [ classList [ ( "Active Room", True ) ] ]
                            [ a [] [ text "Profile" ]
                            ]
                        , li [ classList [ ( "is-active", False ) ] ]
                            [ a [] [ text "Something Else" ]
                            ]
                        ]
                    ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
