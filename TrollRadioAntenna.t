#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>


trollRadioAntenna: ArcticRoom 'Radio Antenna' 'the radio antenna'
  "You are at the foot of a large radio antenna. A narrow, rock-strewn path leads
  down an incline to the west. From this vantage point, you can see the airstrip
  in the distance to the north. "
  west = trollPathWest
  down asExit(west)
;

+ trollPathWest: PathPassage 'small narrow rock-strewn smaller rocky west incline path' 'west path'
  "A small path, strewn with shale and rocks, meanders westwards down an incline between
  some boulders. It ends at a wider, snow-covered path below leading north and south. "
  travelBarrier = [snowMobileSteepBarrier]
;

+ Decoration 'shale/rock/stone/boulder*boulders*rocks*stones' 'boulders'
  "The path to the west is strewn with shale, rocks of various sizes and larger boulders. "
  isPlural = true
;

+ Distant 'airstrip' 'airstrip'
  "Troll Base's airstrip lies far off in the distance. Clearly, the distance was unavoidable
  since the airstrip is the nearest piece of uninterrupted flat ground in the area. "
;

+ radioAntenna: CustomFixture 'radio antenna/tower' 'antenna'
  "The radio antenna is a slender steel tower about ten meters tall. ";
;