module LetterFCompositeMain exposing (..)

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
    p = createPicture fLetter
    composite = above (beside (turn (turn (flip p))) (turn (turn p))) (beside (flip p) p)
    nwBox = box |> flipBox |> turnBox |> turnBox |> scaleVertically 0.5 |> scaleHorizontally 0.5 
    neBox = box |> turnBox |> turnBox |> scaleVertically 0.5 |> scaleHorizontally 0.5 
    swBox = box |> scaleVertically 0.5 |> scaleHorizontally 0.5 
    seBox = box |> flipBox |> scaleVertically 0.5 |> scaleHorizontally 0.5 
  in
    box |> composite
        |> toSvgWithBoxes (400, 400) [ nwBox, neBox, swBox, seBox ]
        |> placeInsideDiv
