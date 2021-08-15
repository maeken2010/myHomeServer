module Pages.Status exposing (Model, Msg, page)

import Gen.Params.Status exposing (Params)
import Page
import Request
import Shared
import View exposing (View)
import Http
import Json.Decode exposing (Decoder, field, float)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import String

page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type Model
  = Failure
  | Loading
  | Success (List Float)


init : ( Model, Cmd Msg )
init =
    (Loading, getStatus)



-- UPDATE


type Msg
  = GotStatus (Result Http.Error (List Float))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotStatus result ->
      case result of
        Ok url ->
          (Success url, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "status"
    , body = [ viewRoot model ]
    }

viewRoot : Model -> Html Msg
viewRoot model =
  div []
    [ h2 [] [ text "Server Status" ]
    , viewStatus model
    ]


viewStatus : Model -> Html Msg
viewStatus model =
  case model of
    Failure ->
      div []
        [ text "error!" ]

    Loading ->
      text "Loading..."

    Success status ->
      div []
        (List.map (\x -> (div [] [text (String.fromFloat x)])) status)

-- HTTP

getStatus : Cmd Msg
getStatus =
  Http.get
    { url = "http://192.168.11.16:5000/api/monitor"
    , expect = Http.expectJson GotStatus statusDecoder
    }


statusDecoder : Decoder (List Float)
statusDecoder =
  field "cpu_percents" (Json.Decode.list float)
