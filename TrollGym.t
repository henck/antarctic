#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// GYM
//

trollGym: TrollRoom 'Gym' 'the gym'
  "The Troll Base's gymnasium is a small room squeezed between the crew 
  quarters and the offices. Most of the space is occupied by a variety 
  of exercise equipment. A smoked glass door leads north, while another 
  door leads south and out to the hallway. "
  north = doorTrollGymNorth
  south = doorTrollGymSouth
  out asExit(south)
;

+ trollGymDoors: CollectiveGroup, SecretFixture '*doors' 'doors'  
  desc() {
    "There is a door labelled <i>Sauna</i> to the north  and a door to the 
    south. ";
    if(doorTrollGymNorth.isOpen && doorTrollGymSouth.isOpen) {
      "Both doors are currently open. ";
    } else if (doorTrollGymNorth.isOpen) {
      "The north door is open. ";
    } else if (doorTrollGymSouth.isOpen) {
      "The south door is open. ";
    } else {
      "Both doors are currently closed. ";
    }
  }
;

+ doorTrollGymSouth: TrollDoor 'south hallway door*doors' 'south door'
  specialNominalRoomPartLocation = trollSouthWall
  collectiveGroups = [trollGymDoors]
;

+ doorTrollGymNorth: RoomPartItem, Door 'north smoked glass sauna pane/door*doors' 'north door'
  "A large smoked glass pane it set in this otherwise white plastic polymer 
  door. There is a small label on it that reads <i>Sauna</i>. The door is 
  currently <<isOpen ? 'open and you can see the sauna through it' : 'closed'>>. "
  masterObject = doorTrollSaunaSouth
  specialNominalRoomPartLocation = trollNorthWall
  openStatusReportable = nil
  specialDesc = "A smoked glass door (<<isOpen ? 'standing open' : 'which is closed'>>) is set in this wall. "  
  collectiveGroups = [trollGymDoors]
;

+ Decoration 'exercise equipment' 'exercise equipment'
  "The available exercise equipment includes a motorized treadmill and an 
  exercise bike. "
;

+ Decoration 'exercise bike/bicycle' 'exercise bike'
  "A bike with no wheels that goes nowhere. Ironic. Still, it must
  help the researchers stationed here keep in shape. "
;

+ Decoration 'motorized treadmill' 'motorized treadmill'
  "This motorized treadmill helps to the researchers stationed here keep
  fit. It sure beats walking outside, since having your nose freeze off 
  isn't anyone's idea of a good time. "
;


