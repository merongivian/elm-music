module Subs exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Keyboard

-- MODEL

type alias Model = Int

init : ( Model, Cmd Msg )
init = ( 0, Cmd.none )

-- MESSAGES

type Msg = KeyUp Keyboard.KeyCode | KeyDown Keyboard.KeyCode

-- VIEW

view : Model -> Html Msg
view model =
  div []
      [ text (toString model) ]

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    KeyDown _ -> ( model + 1, Cmd.none )
    KeyUp _ -> ( model + 1, Cmd.none )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.downs KeyDown
    , Keyboard.ups KeyUp
    ]

-- MAIN

main : Program Never
main =
  Html.App.program
      { init = init
      , view = view
      , update = update
      , subscriptions = subscriptions
      }
