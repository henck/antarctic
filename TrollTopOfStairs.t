#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// TOP OF STAIRS
//

trollTopOfStairs: ArcticRoom 'Top of Stairs' 'the top of the stairs'
  "You are standing on a small elevation at the top of the stairs leading 
  into Troll Base. The entrance to the base is through a white door at the 
  west end of the platform. There is a large sign over the door.
  \bThe platform offers a good view of the structures around the main base. 
  You can see the storage building from here, as well as a vehicle garage 
  and a low, flat building off to the southwest. To the east, the Jutulsessen
  mountains rise up and in the distance to the northeast you spot a radio 
  antenna top of a low hill. "
  west = trollFrontDoorOutside
  down = trollStairsDown
;

+ trollFrontDoorOutside: RoomPartItem, ThroughPassage 'west self-closing thick white polymer front door*doors' 'front door'
  "A self-closing thick white polymer door leads into the warmth of the base. "
  noteTraversal(traveler) { "After {you/he} {goes} through the door, it closes automatically. "; }
  dobjFor(Open) {
    verify() {}
    check() { failCheck('{You/he} push{es} open the door, but its spring mechanism closes it automatically.'); }
  }
  dobjFor(Close) {
    verify() { illogicalAlready('The front door of the base is already closed. '); }
  }
;

++ Component, Decoration 'spring' 'spring'
;

+ Enterable ->trollFrontDoorOutside 'troll base' 'Troll Base'
  "The Troll Base main building is bright red, rectangular and about 30 
  meters long and 10 meters wide, and strongly resembles three large shipping 
  containers welded together. The whole structure is standing on strong steel 
  stilts to allow snow and wind to pass underneath it. "
;

+ trollStairsDown: StairwayDown ->trollStairsUp 'flight/stairs/stairway/steps' 'stairs down'
  "The stairs consist of a few steel steps leading down to the snowy ground. "
  isPlural = true
;

// TODO: Make this multilocs?
+ Distant 'vehicle garage/building' 'vehicle garage'
  "A few discarded vehicle parts leaning against the side of this building make it fairly clear
  that it is a garage. "
;

+ Distant 'storage building' 'storage'
  "From what you've been told, you know that Troll Base was established in 1990, in the original structure
  you're looking at. In 2005, the newer, more expansive section was built and the old structure relegated
  to a storage building. "
;

+ Distant 'radio antenna' 'antenna'
  "Troll Base has a tall radio antenna that helps maintain contact with the rest of the world. "
;

+ CustomFixture 'large sign' 'sign'
  "The sign has a small logo and some writing which reads:
  \b<b>TROLL STATION</b>
  \nLatitude: S 72\u00BA01'  
  \nLongitude: E 02\u00BA32'
  \nAltitude: 1275m above sea level "
  cannotTakeMsg = "You can't reach the sign. "
;

