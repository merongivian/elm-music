module Synthesizer exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Keyboard
import Music

-- MODEL

type alias ON = Bool

init : ( ON, Cmd Msg )
init = ( False, Cmd.none )

-- MESSAGES

type Msg = KeyUp Keyboard.KeyCode
         | KeyDown Keyboard.KeyCode

-- VIEW

view : ON -> Html Msg
view model =
  div []
      [ text (toString model) ]

-- UPDATE

update : Msg -> ON -> ( ON, Cmd Msg )
update msg model =
  case msg of
    KeyDown code ->
      ( True, (Music.playKey code model) )
    KeyUp _ ->
      ( False, Music.mute )

-- SUBSCRIPTIONS

subscriptions : ON -> Sub Msg
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
