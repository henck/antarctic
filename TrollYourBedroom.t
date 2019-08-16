#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// YOUR BEDROOM
//

trollYourBedroom: TrollRoom 'Your bedroom' 'your bedroom'
  "This bedroom doesn't have much in the way of furniture. A small desk 
  sits in a corner with a chair before it and a bed is set against the 
  west wall. A window in the north wall offers a view of the icy landscape 
  around the base. A door (currently <<doorTrollYourBedroomSouth.isOpen 
  ? 'open' : 'closed'>>) leads south and out into a hallway. "
  south = doorTrollYourBedroomSouth
  out asExit(south)
;

+ doorTrollYourBedroomSouth: TrollBedroomDoor 'south door*doors' 'south door'
  masterObject = doorTrollWestHallwayNorth
  specialNominalRoomPartLocation = trollSouthWall
;

// bed
+ Bed, Heavy 'bed*beds/furniture' 'bed'
  "It's lucky that Troll Base has a skeleton staff at this time of year, 
  since a junior researcher like yourself might well be required to share 
  your bed with someone else. Not at the same time, happily: since the sun 
  never sets during the antarctic summer, a rotation scheme is usually 
  implemented. "
;

// desk
+ Surface, Heavy 'small chipped veneered office wooden desk/desktop/top/worktop/frame*furniture' 'desk'
  "The desk is typical office furniture. Its veneered wooden and 
  slightly chipped top rests on a steel frame and there is a drawer 
  mounted under the top. "
;

// drawer
++ OpenableContainer, Component 'metal drawer' 'drawer'
  "The metal drawer, which is <<isOpen ? 'open' : 'closed'>>, is mounted 
  under the desk's worktop. "
  openStatusReportable = nil
;

// bedroom chair
+ Heavy, Chair 'chair*furniture' 'chair'
  "Typical office furniture, the chair consists of a steel frame with a 
  black padded seat and back. It's somewhat heavy and comfortable enough 
  for work, but not for lounging. "
;

// window
+ TrollNorthWindow
;
