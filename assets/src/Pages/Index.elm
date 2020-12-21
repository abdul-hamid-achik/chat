module Pages.Index exposing (Model, Msg, init, view)

import Html exposing (Html, a, button, div, form, h2, input, label, p, text)
import Html.Attributes exposing (class, for, href, id, name, placeholder, type_)
import Html.Events exposing (onInput)



-- MODEL


type alias Model =
    {}



-- INIT


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



-- UPDATE


type Msg
    = Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            ( model, Cmd.none )


view : ( Model, Cmd Msg ) -> Html Msg
view model =
    div [ class "flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8" ]
        [ text "Index Page" ]
