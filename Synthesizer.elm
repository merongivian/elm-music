module Synthesizer exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Keyboard
import Audio

-- MODEL

type alias Volume = Bool

init : ( Volume, Cmd Msg )
init = ( False, Cmd.none )

-- MESSAGES

type Msg = KeyUp Keyboard.KeyCode | KeyDown Keyboard.KeyCode

-- VIEW

view : Volume -> Html Msg
view model =
  div []
      [ text (toString model) ]

-- UPDATE

update : Msg -> Volume -> ( Volume, Cmd Msg )
update msg model =
  case msg of
    KeyDown code ->
      ( False, (Audio.playKey code) )
    KeyUp _ ->
      ( True, Audio.mute )

-- SUBSCRIPTIONS

subscriptions : Volume -> Sub Msg
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
