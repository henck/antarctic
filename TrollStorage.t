#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollStorage: TrollRoom 'Storage Building' 'storage building'
  "You are in the storage building. "
  north = trollDoorStorageWest
;

+ trollDoorStorageWest: RoomPartItem, Door 'hard plastic door*doors' 'door'
  "A hard plastic door (currently <<self.isOpen ? 'open' : 'closed'>>) leads out of the
  storage building and into the cold to the north. "
  openStatusReportable = nil
  specialNominalRoomPartLocation = trollNorthWall
  specialDesc = "A door (<<isOpen ? 'standing open' : 'which is closed'>>) leading 
    out of the storage building is set in this wall. "    
;