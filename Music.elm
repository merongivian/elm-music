port module Music exposing (..)

import Dict exposing (Dict)
import Maybe exposing (Maybe)

port play : (Float) -> Cmd msg
port stop : (Float) -> Cmd msg

type alias Note = String
type alias Frequency = Float
type alias Key = Int
type alias Octave = Int

noteOffset : Note -> Int
noteOffset note =
  case note of
    "B#" -> 0
    "C"  -> 0
    "C#" -> 1
    "Db" -> 1
    "D"  -> 2
    "D#" -> 3
    "Eb" -> 3
    "E"  -> 4
    "Fb" -> 4
    "E#" -> 5
    "F"  -> 5
    "F#" -> 6
    "Gb" -> 6
    "G"  -> 7
    "G#" -> 8
    "Ab" -> 8
    "A"  -> 9
    "A#" -> 10
    "Bb" -> 10
    "B"  -> 11
    "Cb" -> 1
    _    -> 0

baseOctaveNoteToFrequency : Note -> Frequency
baseOctaveNoteToFrequency note =
  let middleC = 440 * (2^(1/12))^(-9)
      distance = noteOffset note
  in
      middleC * ((2^(1/12))^(toFloat distance))

octaveNoteToFrequency : ( Note, Octave ) -> Frequency
octaveNoteToFrequency (note, octave) =
  let octaveDiff = octave - 4
  in
      (baseOctaveNoteToFrequency note) * (2^octaveDiff)

toNoteTuple : Key -> ( Note, Octave )
toNoteTuple key =
  case key of
    65 -> ("C", 3)
    87 -> ("C#", 3)
    83 -> ("D", 3)
    69 -> ("D#", 3)
    68 -> ("E", 3)
    70 -> ("F", 3)
    84 -> ("F#", 3)
    71 -> ("G", 3)
    89 -> ("G#", 3)
    72 -> ("A", 3)
    85 -> ("A#", 3)
    74 -> ("B", 3)
    75 -> ("C", 4)
    79 -> ("C#", 4)
    76 -> ("D", 4)
    _  -> ("C", 1)

keyToFrequency : Key -> Frequency
keyToFrequency key =
  octaveNoteToFrequency (toNoteTuple key)

playKey : Key -> Cmd msg
playKey key =
  let frequency = keyToFrequency key
  in
      play (frequency)

mute : Key -> Cmd mg
mute key =
  stop (keyToFrequency key)
