module Pages.Index exposing (Model, Msg, init, subscriptions, toSession, update, view)

import Html exposing (Html, a, button, div, form, h2, input, label, p, text)
import Html.Attributes exposing (class, for, href, id, name, placeholder, type_)
import Html.Events exposing (onInput)
import Session exposing (Session)
import Types exposing (Message)



-- MODEL


type alias Model =
    { session : Session, messages : List (Maybe Message) }



-- INIT


init : Session -> ( Model, Cmd Msg )
init session =
    let
        messages =
            []
    in
    ( { session = session
      , messages = messages
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Nothing
    | GotSession Session


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSession session ->
            ( { model | session = session }, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : Model -> { title : String, content : Html Msg }
view model =
    { title = "Conduit"
    , content =
        div [ class "flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8" ]
            [ text "Index Page" ]
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Session.changes GotSession (Session.navKey model.session)



-- EXPORT


toSession : Model -> Session
toSession model =
    model.session
