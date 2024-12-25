module HendersonFishSquareLimitMain exposing (..)

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
    box = { a = { x = 0.0, y = 0.0 }
          , b = { x = 400.0, y = 0.0 }
          , c = { x = 0.0, y = 400.0 } }
    p = createPicture fishShapes
    vb = { x = 0, y = 0, width = 400, height = 400 }
    level = 3
   in
    box |> squareLimit level p 
        |> toSvgWithSimpleBoxes vb SolidBox (400, 400) []
        |> placeInsideDiv
