#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>


trollHilltop: ArcticRoom 'Hilltop' 'the hilltop'
  "An outlier of the Jutulsessen mountains, this hilltop gives you an all-round
  view of the area surrounding Troll Base. The mountains rise up sharply to the east,
  while there are foothills to the north and south. A tall radio antenna is some distance 
  away on one of the foothills to the north. The land becomes a wide expanse of snow 
  and ice to the west, interspersed with areas of rock and occasional boulders. Troll 
  Base itself and its surrounding buildings are at the foot of this hill, and a narrow 
  rocky path leads down to it. "
  west = trollPathHilltopWest
  down asExit(west)
;

+ trollPathHilltopWest: PathPassage 'steep descent narrow rocky west path' 'path'
  "Bordered on both sides by thick snow and ice, a narrow rocky path leads west and down to 
  the foot of the hill. It looks like a steep descent. "
;

+ jutulsessen: Distant 'jutulsessen mountain*mountains' 'mountains'
  "Jutulsessen is a <i>nunatak</i><<footnoteNunatak.noteRef>> mountain, which rises to a height of some two 
  kilometers. Since you're quite close to it, the mountain fully dominates the east 
  horizon. "
  isPlural = true
;

+ footnoteNunatak: Footnote
  "A nunatak (from the Inuit <i>nunataq</i>) is an exposed, often rocky element of a ridge, mountain, 
  or peak not covered with ice or snow within (or at the edge of) an ice field or glacier. They are 
  also called glacial islands.
  \bThe term is typically used in areas where a permanent ice sheet is present. Nunataks present readily 
  identifiable landmark reference points in glaciers or ice caps and are often named. ";
;

+ Distant 'foothill/hill*foothills*hills' 'foothills'
  "A ball-shaped antenna array is located on one of the foothills to the north. "
  isPlural = true
;

+ Distant 'radio antenna' 'antenna'
  "A tall radio antenna is on of of the foothills to the north, but it's 
  too far away to make out any detail. "
;

+ Distant 'troll base' 'base'
  "Troll Base lies at the edge of the vase expanse of snow, ice and rocks to the west. 
  From your vantage point you can discern its main building on stilts, the vehicle garage,
  the laboratory and the storage building. "
;

+ Distant 'squarish squat lab/laboratory' 'laboratory'
  "Troll Base's laboratory is a squarish, squat building. "
;

+ Distant 'vehicle garage' 'vehicle garage'
  "While not as large as the principal building, Troll Base's vehicle garage seems large enough
  to accommodate two trucks. "
;

+ Distant 'storage red-painted red building' 'storage building'
  "About a third of the size of the main building, Troll Base's red-painted storage building 
  is closest to your current position. "
;

+ Distant 'main red principal building' 'main building'
  "Troll Base's principal building is rectangular, painted bright red, and placed on stilts. "
;
