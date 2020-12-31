module Main exposing (Model, Msg, subscriptions, update)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, main_, nav, text)
import Html.Attributes exposing (class, href)
import Http
import Pages
import Pages.Index as Index
import Pages.LogIn as LogIn
import Pages.SignUp as SignUp
import Router exposing (fromUrl, linkTo)
import Types exposing (..)
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


type Model
    = LogIn LogIn.Model
    | SignUp SignUp.Model
    | Index Index.Model
    | Pages Router


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | GotIndex Index.Msg
    | GotSignUp SignUp.Msg
    | GotLogIn LogIn.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UrlRequested urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            -- If we got a link that didn't include a fragment,
                            -- it's from one of those (href "") attributes that
                            -- we have to include to make the RealWorld CSS work.
                            --
                            -- In an application doing path routing instead of
                            -- fragment-based routing, this entire
                            -- `case url.fragment of` expression this comment
                            -- is inside would be unnecessary.
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url)
                            )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( UrlChanged url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        _ ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    Pages.init () url key


view : Model -> Browser.Document Msg
view model =
    let
        viewPage page toMsg =
            let
                { title, body } =
                    Pages.view page
            in
            { title = title, body = List.map (Html.map toMsg) body }
    in
    case model of
        Index index ->
            viewPage Types.Index GotIndex (Index.view index)
