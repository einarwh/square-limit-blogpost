module HendersonFishMain exposing (..)

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
    -- box = { a = { x = 60.0, y = 10.0 }
    --       , b = { x = 200.0, y = 0.0 }
    --       , c = { x = 0.0, y = 200.0 } }
    box = { a = { x = 80.0, y = 80.0 }
          , b = { x = 200.0, y = 0.0 }
          , c = { x = 0.0, y = 200.0 } }
    p = createPicture fishShapes
    vb = { x = 20, y = -55, width = 300, height = 200 }
  in
    box |> p
        |> toSvgWithSimpleBoxes vb (300, 225) [ box ]
        -- |> toSvgWithSimpleBoxes (270, 220) [ box ]
        |> placeInsideDiv
