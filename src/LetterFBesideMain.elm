module LetterFBesideMain exposing (..)

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
    -- box = { a = { x = 80.0, y = 80.0 }
    --       , b = { x = 200.0, y = 0.0 }
    --       , c = { x = 0.0, y = 200.0 } }
    box = { a = { x = 60.0, y = 60.0 }
          , b = { x = 150.0, y = 0.0 }
          , c = { x = 0.0, y = 150.0 } }
    svgDim = (300, 300)
    fPicture = createPicture fLetter
    composite = beside fPicture (turn fPicture)
    leftBox = (box |> scaleHorizontally 0.5)
    rightBox = box |> moveHorizontally 0.5 |> scaleHorizontally 0.5 |> turnBox
  in 
    box |> composite
        |> toSvgWithBoxes svgDim [ leftBox, rightBox ]
        |> placeInsideDiv
