module Pages exposing (Page, view)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, div, main_, nav, text)
import Html.Attributes exposing (class, href)
import Pages.Index as IndexPage
import Pages.LogIn as LogInPage
import Pages.SignUp as SignUpPage
import Route exposing (fromUrl)
import Types exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, map, oneOf, s, top)
import Viewer exposing (Viewer)


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | GotSignUpMsg SignUpPage.Msg
    | GotLogInMsg LogInPage.Msg
    | GotIndexMsg IndexPage.Msg


type Page
    = Other
    | Index
    | LogIn
    | SignUp
    | Redirect
    | NotFound


isActive : Page -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Index, Types.Index ) ->
            True

        ( LogIn, Types.LogIn ) ->
            True

        ( SignUp, Types.SignUp ) ->
            True

        _ ->
            False


getLinkClass : Page -> Route -> String
getLinkClass page route =
    case isActive page route of
        True ->
            "bg-gray-900 text-white"

        False ->
            "text-gray-300 hover:bg-gray-700 hover:text-white"


navbarLink : Page -> Route -> List (Html msg) -> Html msg
navbarLink page route linkContent =
    a [ class (getLinkClass page route), Route.href route ] linkContent


viewHeader : Page -> Maybe Viewer -> Html msg
viewHeader page maybeViewer =
    nav [ class "bg-gray-800" ]
        [ div [ class "max-w-7xl mx-auto px-2 sm:px-6 lg:px-8" ]
            [ div [ class "relative flex items-center justify-between h-16" ]
                [ div [ class "flex-1 flex items-center justify-center sm:items-stretch sm:justify-start" ]
                    [ div [ class "hidden sm:block sm:ml-6" ]
                        [ div [ class "flex space-x-4" ] <|
                            navbarLink
                                page
                                Types.Index
                                [ text "Index" ]
                                :: viewMenu page maybeViewer
                        ]
                    ]
                ]
            ]
        ]


viewMenu : Page -> Maybe Viewer -> List (Html msg)
viewMenu page maybeViewer =
    let
        linkTo =
            navbarLink page
    in
    case maybeViewer of
        Just viewer ->
            let
                _ =
                    Viewer.username viewer
            in
            [ linkTo
                Types.LogOut
                [ text "Logout" ]
            ]

        Nothing ->
            [ linkTo Types.LogIn [ text "Sign in" ]
            , linkTo Types.SignUp [ text "Sign up" ]
            ]


view : Maybe Viewer -> Page -> { title : String, content : Html msg } -> Document msg
view maybeViewer page { title, content } =
    { title = title ++ " - Elm Chat"
    , body =
        [ div [ class "min-h-screen bg-white" ]
            [ viewHeader page maybeViewer
            , div [ class "py-10" ]
                [ main_ []
                    [ div [ class "max-w-7xl mx-auto sm:px-6 lg:px-8" ]
                        [ content
                        ]
                    ]
                ]
            ]
        ]
    }
