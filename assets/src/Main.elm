module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, main_, nav, text)
import Html.Attributes exposing (class, href)
import Pages.LogIn
import Pages.SignUp
import Router exposing (Route(..), fromUrl, linkTo)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, map, oneOf, s, top)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


type alias Flags =
    {}


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


content : Model -> Html msg
content model =
    case model.route of
        SignUp ->
            Pages.SignUp.render

        LogIn ->
            Pages.LogIn.render

        Index ->
            indexPage model

        _ ->
            indexPage model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Router.NotFound, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | route = fromUrl url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


indexPage : Model -> Html msg
indexPage model =
    div []
        [ text "index page"
        ]


navbar : Model -> Html msg
navbar model =
    nav [ class "bg-gray-800" ]
        [ div [ class "max-w-7xl mx-auto px-2 sm:px-6 lg:px-8" ]
            [ div [ class "relative flex items-center justify-between h-16" ]
                [ div [ class "flex-1 flex items-center justify-center sm:items-stretch sm:justify-start" ]
                    [ div [ class "hidden sm:block sm:ml-6" ]
                        [ div [ class "flex space-x-4" ]
                            [ linkTo Index model.route
                            , linkTo SignUp model.route
                            , linkTo LogIn model.route
                            ]
                        ]
                    ]
                ]
            ]
        ]


view : Model -> Browser.Document msg
view model =
    { title = "Chat by Abdul Hamid"
    , body =
        [ div [ class "min-h-screen bg-white" ]
            [ navbar model
            , div [ class "py-10" ]
                [ main_ []
                    [ div [ class "max-w-7xl mx-auto sm:px-6 lg:px-8" ]
                        [ content model
                        ]
                    ]
                ]
            ]
        ]
    }
