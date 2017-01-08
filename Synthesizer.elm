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
  let
      handlePlay code = not (List.member code model)
      removeFromCurrentKeys code = List.filter (\code -> code /= code) model
      insertInCurrentKeys code = case List.member code model of
                                   True -> model
                                   False -> code :: model
  in
    case msg of
      KeyDown code ->
        ( insertInCurrentKeys code, (Music.playKey code (handlePlay code)) )
      KeyUp code ->
        ( removeFromCurrentKeys code, Music.mute code )

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
