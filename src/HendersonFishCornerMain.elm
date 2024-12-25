module HendersonFishCornerMain exposing (..)

import Letter exposing (..)
import Fitting exposing (createPicture)
import Box exposing (..)
import Picture exposing (..)
import Rendering exposing (..)
import Svg exposing (Svg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Fishy exposing (fishShapes)
import Recursion exposing (sideBoxes, cornerBoxes)
import Gather exposing (gatherBoxes)

placeInsideDiv : Svg msg -> Html msg 
placeInsideDiv svg = 
  div [ style "padding" "50px" ] [ svg ]

main : Svg msg
main = 
  let 
    box = { a = { x = 40.0, y = 20.0 }
          , b = { x = 260.0, y = 0.0 }
          , c = { x = 0.0, y = 260.0 } }
    p = createPicture fishShapes
    vb = { x = 0, y = 0, width = 340, height = 290 }
    level = 1
    boxes = cornerBoxes level box 
   in
    box |> corner level p 
        |> toSvgWithSimpleBoxes vb SolidBox (340, 290) boxes
        |> placeInsideDiv
