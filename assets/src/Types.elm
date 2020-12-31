module Types exposing (..)

import Browser.Navigation as Nav
import Url exposing (Url)


type alias Item =
    {}


type Route
    = NotFound
    | SignUp
    | LogIn
    | Index


type alias Router =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }
