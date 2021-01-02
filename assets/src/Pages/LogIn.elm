module Pages.LogIn exposing (Model, Msg, init, subscriptions, toSession, update, view)

{-| The login page.
-}

import Api exposing (Cred)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, decodeString, field, string)
import Json.Decode.Pipeline exposing (optional)
import Json.Encode as Encode
import Route
import Session exposing (Session)
import Types exposing (Route)
import Viewer exposing (Viewer)



-- MODEL


type ValidatedField
    = Email
    | Password


type Problem
    = InvalidEntry ValidatedField String
    | ServerError String


type alias Model =
    { session : Session
    , problems : List Problem
    , form : Form
    }


type alias Form =
    { email : String, password : String }


type TrimmedForm
    = Trimmed Form


fieldsToValidate : List ValidatedField
fieldsToValidate =
    [ Email
    , Password
    ]


toSession : Model -> Session
toSession model =
    model.session


login : TrimmedForm -> Cmd Viewer
login (Trimmed form) =
    let
        user =
            Encode.object
                [ ( "email", Encode.string form.email )
                , ( "password", Encode.string form.password )
                ]

        body =
            Encode.object [ ( "user", user ) ]
                |> Http.jsonBody
    in
    Api.login body Viewer.decoder


trimFields : Form -> TrimmedForm
trimFields form =
    Trimmed
        { email = String.trim form.email
        , password = String.trim form.password
        }


validate : Form -> Result (List Problem) TrimmedForm
validate form =
    let
        trimmedForm =
            trimFields form
    in
    case List.concatMap (validateField trimmedForm) fieldsToValidate of
        [] ->
            Ok trimmedForm

        problems ->
            Err problems


validateField : TrimmedForm -> ValidatedField -> List Problem
validateField (Trimmed form) field =
    List.map (InvalidEntry field) <|
        case field of
            Email ->
                if String.isEmpty form.email then
                    [ "email can't be blank." ]

                else
                    []

            Password ->
                if String.isEmpty form.password then
                    [ "password can't be blank." ]

                else
                    []



-- INIT


init : Session -> ( Model, Cmd msg )
init session =
    ( { session = session
      , problems = []
      , form =
            { email = ""
            , password = ""
            }
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = SubmittedForm
    | EnteredEmail String
    | EnteredPassword String
    | CompletedLogin (Result Http.Error Viewer)
    | GotSession Session


updateForm : (Form -> Form) -> Model -> ( Model, Cmd Msg )
updateForm transform model =
    ( { model | form = transform model.form }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SubmittedForm ->
            case validate model.form of
                Ok validForm ->
                    ( { model | problems = [] }
                    , CompletedLogin (login validForm)
                    )

                Err problems ->
                    ( { model | problems = problems }
                    , Cmd.none
                    )

        EnteredEmail email ->
            updateForm (\form -> { form | email = email }) model

        EnteredPassword password ->
            updateForm (\form -> { form | password = password }) model

        CompletedLogin (Err error) ->
            let
                serverErrors =
                    Api.decodeErrors error
                        |> List.map ServerError
            in
            ( { model | problems = List.append model.problems serverErrors }
            , Cmd.none
            )

        CompletedLogin (Ok viewer) ->
            ( model
            , Viewer.store viewer
            )

        GotSession session ->
            ( { model | session = session }
            , Route.replaceUrl (Session.navKey session) Types.Index
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Session.changes GotSession (Session.navKey model.session)



-- VIEW


viewForm : Form -> Html Msg
viewForm form =
    Html.form [ class "mt-8 space-y-6", onSubmit SubmittedForm ]
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
                    , class "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 rounded-b-md placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                    ]
                    []
                ]
            ]
        , div []
            [ button [ type_ "submit", class "group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" ]
                [ text "Sign In"
                ]
            ]
        ]


view : Model -> { title : String, content : Html Msg }
view model =
    { title = "Login"
    , content =
        div [ class "flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8" ]
            [ div [ class "max-w-md w-full space-y-8" ]
                [ div []
                    [ h2 [ class "mt-6 text-center text-3xl font-extrabold text-gray-900" ]
                        [ text "Log in to your account"
                        ]
                    , p []
                        [ text "Or "
                        , a [ class "font-medium text-indigo-600 hover:text-indigo-500", href "/signup" ]
                            [ text "Sign Up"
                            ]
                        ]
                    ]
                , viewForm model.form
                ]
            ]
    }
