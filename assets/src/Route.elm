module Route exposing (fromUrl, href, replaceUrl)

import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, text)
import Html.Attributes as Attr exposing (class, href)
import Types exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing (..)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Index top
        , map LogIn (s "login")
        , map SignUp (s "signup")
        ]


href : Route -> Attribute msg
href targetRoute =
    Attr.href (routeToString targetRoute)



--linkTo : Route -> Route -> Html msg
--linkTo route currentUrl =
--    case route of
--        Index ->
--            a [ href "/", class (getLinkClass currentUrl Index) ] [ text "Index" ]
--        SignUp ->
--            a [ href "/signup", class (getLinkClass currentUrl SignUp) ] [ text "Sign Up" ]
--        LogIn ->
--            a [ href "/login", class (getLinkClass currentUrl LogIn) ] [ text "Log In" ]
--        _ ->
--            text "Invalid"


routeToPieces : Route -> List String
routeToPieces page =
    case page of
        Index ->
            []

        Root ->
            []

        LogIn ->
            [ "login" ]

        LogOut ->
            [ "logout" ]

        SignUp ->
            [ "signup" ]

        _ ->
            [ "404" ]



-- INTERNAL


routeToString : Route -> String
routeToString page =
    "#/" ++ String.join "/" (routeToPieces page)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser
