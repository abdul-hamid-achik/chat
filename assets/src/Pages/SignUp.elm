module Pages.SignUp exposing (Model, Msg, init, update, view)

import Debug
import Html exposing (Html, a, button, div, form, h2, input, label, p, text)
import Html.Attributes exposing (class, for, href, id, name, placeholder, type_)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Json.Decode exposing (list, string)
import Json.Encode as Encode



-- MODEL


type alias Model =
    { form : Form }


type alias Form =
    { email : String, password : String, confirm_password : String }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { form = { email = "", password = "", confirm_password = "" } }, Cmd.none )



-- UPDATE


type Msg
    = Reset
    | EmailChange String
    | PasswordChange String
    | ConfirmPasswordChange String
    | FormSubmit
    | GotResponse (Result Http.Error (List String))
    | PreventDefault


serializeForm : Form -> Http.Body
serializeForm form =
    Encode.object
        [ ( "email", Encode.string form.email )
        , ( "password", Encode.string form.password )
        , ( "confirm_password", Encode.string form.confirm_password )
        ]
        |> Http.jsonBody


submitForm : Model -> Cmd Msg
submitForm model =
    let
        _ =
            Debug.log "submitting form " model
    in
    Http.post
        { url = "/sessions"
        , body = serializeForm model.form
        , expect = Http.expectJson GotResponse (list string)
        }


updateForm : (Form -> Form) -> Model -> ( Model, Cmd Msg )
updateForm transform model =
    ( { model | form = transform model.form }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            ( model, Cmd.none )

        EmailChange email ->
            updateForm (\form -> { form | email = email }) model

        PasswordChange password ->
            updateForm (\form -> { form | password = password }) model

        ConfirmPasswordChange password ->
            updateForm (\form -> { form | confirm_password = password }) model

        FormSubmit ->
            let
                handle =
                    submitForm model

                _ =
                    Debug.log "form submit" handle
            in
            ( model, handle )

        GotResponse response ->
            let
                _ =
                    Debug.log "got response" response
            in
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : ( Model, Cmd Msg ) -> Html Msg
view model =
    div [ class "flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8" ]
        [ div [ class "max-w-md w-full space-y-8" ]
            [ div []
                [ h2 [ class "mt-6 text-center text-3xl font-extrabold text-gray-900" ]
                    [ text "Sign Up"
                    ]
                , p []
                    [ text "Or "
                    , a [ class "font-medium text-indigo-600 hover:text-indigo-500", href "/login" ]
                        [ text "Log in"
                        ]
                    ]
                ]
            , form [ class "mt-8 space-y-6", onSubmit PreventDefault ]
                [ div [ class "rounded-md shadow-sm -space-y-px" ]
                    [ div []
                        [ label
                            [ for "email"
                            , class "sr-only"
                            ]
                            [ text "Email Address" ]
                        , input
                            [ id "email"
                            , type_ "email"
                            , placeholder "Email Address"
                            , name "email"
                            , class "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                            , onInput EmailChange
                            ]
                            []
                        ]
                    , div []
                        [ label
                            [ for "password"
                            , class "sr-only"
                            ]
                            [ text "Password" ]
                        , input
                            [ id "password"
                            , type_ "password"
                            , placeholder "Password"
                            , name "password"
                            , class "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                            ]
                            []
                        ]
                    , div []
                        [ label
                            [ for "confirm_password"
                            , class "sr-only"
                            ]
                            [ text "Password" ]
                        , input
                            [ id "confirm_password"
                            , type_ "password"
                            , placeholder "Confirm Password"
                            , name "confirm_password"
                            , class "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                            ]
                            []
                        ]
                    ]
                , div []
                    [ button
                        [ type_ "submit"
                        , class "group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                        , onClick FormSubmit
                        ]
                        [ text "Sign Up"
                        ]
                    ]
                ]
            ]
        ]
