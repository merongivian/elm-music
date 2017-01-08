module Synthesizer exposing (..)

import Html exposing (Html, div, text)
import List exposing (member, filter)
import Html.App
import Keyboard
import Music

-- MODEL

type alias CurrentKeys = List Int

init : ( CurrentKeys, Cmd Msg )
init = ( [], Cmd.none )

-- MESSAGES

type Msg = KeyUp Keyboard.KeyCode
         | KeyDown Keyboard.KeyCode

-- VIEW

view : CurrentKeys -> Html Msg
view model =
  div []
      [ text (toString model) ]

-- UPDATE

update : Msg -> CurrentKeys -> ( CurrentKeys, Cmd Msg )
update msg model =
  case msg of
    KeyDown code ->
      if (List.member code model) then
        ( model, Cmd.none )
      else
        ( code :: model, (Music.playKey code) )
    KeyUp code ->
      if (List.member code model) then
        let removeFromCurrentKeys keycode = List.filter (\savedCode -> savedCode /= keycode) model
        in
          ( removeFromCurrentKeys code, Music.mute code )
      else
        ( model, Cmd.none )

-- SUBSCRIPTIONS

subscriptions : CurrentKeys -> Sub Msg
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
