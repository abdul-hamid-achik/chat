module Router exposing (fromUrl, linkTo)

import Html exposing (Html, a, text)
import Html.Attributes exposing (class, href)
import Types exposing (..)
import Url exposing (Url)
import Url.Parser exposing (..)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Index top
        , map LogIn (s "login")
        , map SignUp (s "signup")
        ]


activeClass : String
activeClass =
    "bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium"


linkClass : String
linkClass =
    "text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium"


getLinkClass : Route -> Route -> String
getLinkClass currentRoute route =
    if currentRoute == route then
        activeClass

    else
        linkClass


linkTo : Route -> Route -> Html msg
linkTo route currentUrl =
    case route of
        Index ->
            a [ href "/", class (getLinkClass currentUrl Index) ] [ text "Index" ]

        SignUp ->
            a [ href "/signup", class (getLinkClass currentUrl SignUp) ] [ text "Sign Up" ]

        LogIn ->
            a [ href "/login", class (getLinkClass currentUrl LogIn) ] [ text "Log In" ]

        _ ->
            text "Invalid"


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (parse parser url)
