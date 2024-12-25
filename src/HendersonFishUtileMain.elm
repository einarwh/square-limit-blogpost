module HendersonFishUtileMain exposing (..)

import Letter exposing (..)
import Fitting exposing (createPicture)
import Box exposing (..)
import Picture exposing (..)
import Rendering exposing (..)
import Svg exposing (Svg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Fishy exposing (fishShapes)

placeInsideDiv : Svg msg -> Html msg 
placeInsideDiv svg = 
  div [ style "padding" "50px" ] [ svg ]

main : Svg msg
main = 
  let 
    box = { a = { x = 80.0, y = 80.0 }
          , b = { x = 180.0, y = 0.0 }
          , c = { x = 0.0, y = 180.0 } }
    p = createPicture fishShapes
    vb = { x = -20, y = 20, width = 400, height = 380 }
    boxes = 
        [ tossBox box 
        , (turnBox >> tossBox) box 
        , (turnBox >> turnBox >> tossBox) box 
        , (turnBox >> turnBox >> turnBox >> tossBox) box ]
  in
    box |> utile p 
        |> toSvgWithSimpleBoxes vb (400, 380) boxes
        |> placeInsideDiv
