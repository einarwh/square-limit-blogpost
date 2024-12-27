module Picture exposing (..)

import Box exposing (..)
import Shape exposing (..)
import Style exposing (..)

type alias Rendering = List (Shape, Style)

type alias Picture = Box -> Rendering  

blank : Picture 
blank _ = []

-- Exercise 1

turn : Picture -> Picture
turn p = turnBox >> p

-- Entirely optional bonus exercise:
times : Int -> (a -> a) -> (a -> a)
times n fn = identity

-- Exercise 2

flip : Picture -> Picture 
flip p = flipBox >> p 

-- Exercise 3

toss : Picture -> Picture 
toss p = tossBox >> p 

-- Exercise 4

aboveRatio : Int -> Int -> Picture -> Picture -> Picture
aboveRatio m n p1 p2 =
  \box ->
    let
      f = toFloat m / toFloat (m + n)
      (b1, b2) = splitVertically f box
    in
      (p1 b1) ++ (p2 b2)

above : Picture -> Picture -> Picture
above = aboveRatio 1 1

-- Exercise 5

besideRatio : Int -> Int -> Picture -> Picture -> Picture
besideRatio m n p1 p2 =
  \box ->
    let
      f = toFloat m / toFloat (m + n)
      (b1, b2) = splitHorizontally f box
    in
      (p1 b1) ++ (p2 b2)

beside : Picture -> Picture -> Picture
beside = besideRatio 1 1

-- Exercise 6

-- quartet : 4 pictures arranged in 2 x 2 grid
quartet : Picture -> Picture -> Picture -> Picture -> Picture
quartet nw ne sw se =
  above (beside nw ne)
        (beside sw se)

-- Exercise 7

-- nonet : 9 pictures arranged in 3 x 3 grid
nonet : Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture
nonet nw nm ne mw mm me sw sm se =
  let
    row w m e = besideRatio 1 2 w (beside m e)
    col n m s = aboveRatio 1 2 n (above m s)
  in
    col (row nw nm ne)
        (row mw mm me)
        (row sw sm se)

-- Exercise 8

over : Picture -> Picture -> Picture
over p1 p2 = 
  \box -> (p1 box) ++ (p2 box)

-- Exercise 9

ttile : Picture -> Picture
ttile fish =
  let
    fishN = fish |> toss |> flip
    fishE = fishN |> turn |> turn |> turn
  in
    fish |> over fishN |> over fishE

cycle : Picture -> Picture 
cycle p = 
  let
    ne = p 
    nw = p |> turn 
    sw = p |> turn |> turn 
    se = p |> turn |> turn |> turn 
  in
    quartet nw ne sw se 

tosstile : Picture -> Picture
tosstile fish =
  let
    fishN = fish |> toss |> flip
    fishE = fishN |> turn |> turn |> turn
  in
    fish |> over fishE

tossfish : Int -> Picture -> Picture 
tossfish n p = 
  if n < 1 then blank
  else 

    -- over (tosstile p) (tossfish (n - 1) (toss p))
    over (tosstile p) ((tosstile p) |> toss |> flip)
-- Exercise 10

tossalot : Picture -> Picture
tossalot fish =
  let
    fishN = fish |> toss |> flip
    fishE = fishN |> turn |> turn |> turn
    fishTT = fish |> toss |> toss 
    fishTTTT = fishTT |> toss |> toss 
    fishTTTTTT = fishTTTT |> toss |> toss 
    fishNTT = fishN |> toss |> toss
    fishNTTTT = fishNTT |> toss |> toss
    fishETT = fishE |> toss |> toss
    fishETTTT = fishETT |> toss |> toss
    fishETTTTTT = fishETTTT |> toss |> toss
    fishX = fishN |> flip |> turn |> turn |> turn |> toss
    fishXTT = fishX |> toss |> toss 
    fishXTTTT = fishXTT |> toss |> toss 
    fishXTTTTTT = fishXTTTT |> toss |> toss 
  in
    fish 
    |> over fishN 
    |> over fishE 
    |> over fishTT
    |> over fishTTTT
    |> over fishTTTTTT
    |> over fishETT
    |> over fishETTTT
    -- |> over fishETTTTTT
    |> over fishNTT
    |> over fishNTTTT
    |> over fishX
    |> over fishXTT
    |> over fishXTTTT
    -- |> over fishXTTTTTT

utile : Picture -> Picture
utile fish =
  let
    fishN = fish |> toss |> flip
    fishW = fishN |> turn
    fishS = fishW |> turn
    fishE = fishS |> turn
  in
    fishN |> over fishW |> over fishS |> over fishE

-- Exercise 11

side : Int -> Picture -> Picture
side n fish =
  if n < 1 then blank
  else
    let
      s = side (n - 1) fish
      t = ttile fish
    in
      quartet s s (turn t) t

-- Exercise 12

corner : Int -> Picture -> Picture
corner n fish =
  if n < 1 then blank
  else
    let
      c = corner (n - 1) fish
      s = side (n - 1) fish
    in
      quartet c s (turn s) (utile fish)

-- Exercise 13

squareLimit : Int -> Picture -> Picture
squareLimit n fish =
  let
    mm = utile fish
    nw = corner n fish
    sw = nw |> turn
    se = sw |> turn
    ne = se |> turn
    nm = side n fish
    mw = nm |> turn
    sm = mw |> turn
    me = sm |> turn
  in
    nonet nw nm ne mw mm me sw sm se
