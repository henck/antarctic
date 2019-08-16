#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// EAST HALLWAY
//

trollEastHallway: TrollRoom 'East Hallway' 'the east hallway'
  "This is the east hallway. "
  west = trollCentralHallway
  east = trollFrontDoorInside
  south = trollDoorEastHallwaySouth
  north = trollDoorEastHallwayNorth
  out asExit(east)
;

+ trollEastHallwayDoors: CollectiveGroup, SecretFixture '*doors' 'doors'  
  desc() {
    "There is a door labelled <i>Office Space</i> (currently 
    <<trollDoorEastHallwayNorth.isOpen ? 'open' : 'closed'>>) to the north 
    and a door labelled <i>Comm Center</i> (currently 
    <<trollDoorEastHallwaySouth.isOpen ? 'open' : 'closed'>>) to the south. 
    The front door of Troll Base is to the east. ";
  }
;

+ trollFrontDoorInside: RoomPartItem, ThroughPassage 'self-closing thick white base polymer east front door*doors' 'east door'
  "A self-closing thick white polymer door leads out of the base and into 
  the cold. It's equipped with a spring that closes it automatically. "
  noteTraversal(traveler) { "After {you/he} {goes} through the door, it closes automatically. "; }
  masterObject = trollFrontDoorOutside
  specialNominalRoomPartLocation = trollEastWall
  specialDesc = "The base front door is set in this wall. "  
  collectiveGroups = [trollEastHallwayDoors]
  dobjFor(Open) {
    verify() {}
    check() { failCheck('{You/he} pull{s} open the front door, but its spring mechanism closes it automatically.'); }
  }
  dobjFor(Close) {
    verify() { illogicalAlready('The front door is already closed. '); }
  }  
;

++ Component, Decoration 'spring' 'spring'
;

+ trollDoorEastHallwayNorth: TrollDoor 'north office door*doors' 'north door'
  customDesc() {
    inherited;
    "This door is labelled <i>Office Space</i>. ";
  }
  specialNominalRoomPartLocation = trollNorthWall
  collectiveGroups = [trollEastHallwayDoors]
;

+ trollDoorEastHallwaySouth: TrollDoor 'south comm center communications door*doors' 'south door'
  customDesc() {
    inherited;
    "This door is labelled <i>Comm Center</i>. ";
  }     
  specialNominalRoomPartLocation = trollSouthWall
  collectiveGroups = [trollEastHallwayDoors]
;

