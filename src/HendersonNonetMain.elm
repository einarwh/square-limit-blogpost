module HendersonNonetMain exposing (..)

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
    box = { a = { x = 10.0, y = 10.0 }
          , b = { x = 280.0, y = 0.0 }
          , c = { x = 0.0, y = 280.0 } }
    h = createPicture hLetter
    e = createPicture eLetter
    n = createPicture nLetter
    d = createPicture dLetter
    r = createPicture rLetter
    s = createPicture sLetter
    o = createPicture oLetter
    vb = { x = 0, y = 0, width = 300, height = 300 }
    scaled1 = box |> scaleVertically (1.0 / 3.0) |> scaleHorizontally (1.0 / 3.0)
    scaled2 = scaled1 |> moveHorizontally 1.0
    scaled3 = scaled2 |> moveHorizontally 1.0
    boxes = 
        [ scaled1 
        , scaled1 |> moveVertically 1.0 
        , scaled1 |> moveVertically 2.0
        , scaled2 
        , scaled2 |> moveVertically 1.0 
        , scaled2 |> moveVertically 2.0
        , scaled3 
        , scaled3 |> moveVertically 1.0 
        , scaled3 |> moveVertically 2.0
        ]
  in
    box |> nonet h e n d e r s o n 
        |> toSvgWithSimpleBoxes vb DottedBox (300, 300) boxes
        |> placeInsideDiv
