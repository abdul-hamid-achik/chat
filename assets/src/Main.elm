module Main exposing (main)

import Api exposing (Cred)
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, div, main_, nav, text)
import Html.Attributes exposing (class, href)
import Http
import Json.Decode as Decode exposing (Value)
import Pages exposing (Page)
import Pages.Index as Index
import Pages.LogIn as LogIn
import Pages.SignUp as SignUp
import Route exposing (fromUrl)
import Session exposing (Session)
import Types exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, map, oneOf, s, top)
import Username exposing (Username)
import Viewer exposing (Viewer)


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
    = Redirect Session
    | NotFound Session
    | LogIn LogIn.Model
    | SignUp SignUp.Model
    | Index Index.Model


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


init : Maybe Viewer -> Url -> Nav.Key -> ( Model, Cmd Msg )
init maybeViewer url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromViewer navKey maybeViewer))


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Index index ->
            Index.toSession index

        LogIn login ->
            LogIn.toSession login

        SignUp signup ->
            Register.toSession signup


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Types.Root ->
            ( model, Route.replaceUrl (Session.navKey session) Route.Home )

        Just Types.LogOut ->
            ( model, Api.logout )

        Just Types.Index ->
            Index.init session
                |> updateWith Index GotIndexMsg model

        Just Types.LogIn ->
            LogIn.init session
                |> updateWith Login GotLoginMsg model

        Just Types.SignUp ->
            SignUp.init session
                |> updateWith SignUp GotSignUpMsg model


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


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
            viewPage Page.Index GotIndex (Index.view index)

        LogIn login ->
            viewPage Pages.Other GotLoginMsg (Login.view login)

        Register register ->
            viewPage Page.Other GotRegisterMsg (Register.view register)
