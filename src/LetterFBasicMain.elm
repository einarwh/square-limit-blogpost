module LetterFBasicMain exposing (main)

import Letter exposing (..)
import Fitting exposing (createPicture)
import Box exposing (..)
import Picture exposing (..)
import Rendering exposing (..)
import Svg exposing (Svg)
import Html exposing (..)
import Html.Attributes exposing (..)

placeInsideDiv : Svg msg -> Html msg 
placeInsideDiv svg = 
  div [ style "padding" "50px" ] [ svg ]

main : Svg msg
main = 
  let 
    box = { a = { x = 80.0, y = 80.0 }
          , b = { x = 200.0, y = 0.0 }
          , c = { x = 0.0, y = 200.0 } }
  in
    box |> createPicture fLetter
        |> toSvgWithBoxes (400, 400) [ box ]
        |> placeInsideDiv
