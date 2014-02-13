# Animo engine design

Todo:

- smooth animation
- smooth zoom
- play talk sound on command receive
- play talk animation on command receive
- read in RDF 
- process RDF items as commands

Read in events from csv/json

## Scene
- bg image
- objects/actors
- events

## Object
- sprite
- animations
- position
- rotation
- scale
- movement (tween: position/rotation/scale) 

## Actor < Object
(everything from object)

- dialogue

later:

- motivations
- other semantic stuff

## Event
- time
- duration
- object/actor
+ trigger

Maybe?
- action (animation/movement/music/dialogue)

## Movement < Event
- startloc (can be set to a const like STAGE_LEFT, or can be worked out based on size)
- endloc
- startsize
- endsize
- easing?

## Speak < Event
- dialogue


