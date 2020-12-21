module Pages.LogIn exposing (Model, Msg, init, view)

import Html exposing (Html, a, button, div, form, h2, input, label, p, text)
import Html.Attributes exposing (class, for, href, id, name, placeholder, type_)



-- MODEL


type alias Model =
    { form : Form }


type alias Form =
    { email : Maybe String, password : Maybe String }



-- INIT


init : ( Model, Cmd msg )
init =
    ( { form = { email = Nothing, password = Nothing } }, Cmd.none )



-- UPDATE


type Msg
    = Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            model



-- VIEW


view : ( Model, Cmd Msg ) -> Html msg
view model =
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
            , form [ class "mt-8 space-y-6" ]
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
                        [ text "Login"
                        ]
                    ]
                ]
            ]
        ]
