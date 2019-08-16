#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// FRONT OF BASE
//

trollFrontOfBase: ArcticRoom 'Front of Base' 'the front of Troll Base'
  "This is a small snowy field in front of Troll Base. A short flight of steel 
  steps leads up to a platform with a door leading into the base proper. 
  A small grey building stands just to the west, with a sign saying <i>Laboratory</i>
  over its <<trollLaboratoryOutside.location == self ? 'door' : 'open doorway'>>. 
  A larger structure to the south is clearly a vehicle garage, its door opened
  a crack. "
  
  pic: Picture { picFile = 'pics/frontOfBase' }
  
  up = trollStairsUp
  east = trollFootOfHill
  west = trollLaboratoryOutside
  south = trollGarageOutside
  
  // The wind blows the laboratory door shut occasionally (if it exists, and if it's open).
  roomAfterAction
  {
    if(trollLaboratoryOutside.isIn(trollFrontOfBase) && trollLaboratoryOutside.isOpen && rand(3) == 0) {
      trollLaboratoryOutside.makeOpen(nil);
      "A hard gust of wind hits the laboratory door and slams it shut with a bang. ";
    }
  }  
;

// You can't ride the snowmobile up the stairs.
+ trollStairsUp: StairwayUp 'flight/stairs/stairway/steps' 'stairs up'
  "The stairs consist of a few steel steps leading up to a small platform. The entrance
  to Troll Base is through a door at the top of the platform. "
  isPlural = true
  travelBarrier = [snowMobileStandardBarrier]
;

+ Distant 'front door*doors' 'front door'
  "A door at the top of the stairs leads into Troll Base. "
  dobjFor(Open) {
    verify() { illogical('You will need to climb the stairs first in order to get close enough to the door.'); }
  }
;

+ Decoration 'sign' 'sign'
  "The sign says <i>Laboratory</i>. "
;

// Lab door
+ trollLaboratoryOutside: LockableWithKey, Door 'lab laboratory door*doors' 'laboratory door'
  desc() {
    if(isOpen)
      "An open metal door with a small ice-crusted window leads into the 
      laboratory. The door has a steel handle and a keyhole. ";
    else
      "A metal door (currently closed) with a small ice-crusted window 
      offers access to the laboratory. The door has a steel handle and a 
      keyhole. ";
  }
  initiallyLocked = true
  lockStatusObvious = nil
  openStatusReportable = nil
  keyList = [labKey]
  travelBarrier = [snowMobileStandardBarrier]
  dobjFor(UnlockWith) {
    check() { 
      reportFailure('The lock is covered with a thick layer of ice. There\'s no way to insert the key. '); 
      if(agnesStuckInLab.isIn(trollFrontOfBase)) {
        if(agnesStuckInLab.curState == agnesStuckInLab_Init) {
          agnesStuckInLab.setCurState(agnesStuckInLab_WantsCut);
        }
        if(agnesStuckInLab.curState == agnesStuckInLab_FindKey) {
          agnesStuckInLab.setCurState(agnesStuckInLab_WantsKey);
        }
      }      
      exit;
    }
  }
  dobjFor(LockWith) {
    check() { 
      failCheck('The lock is covered with a thick layer of ice. There\'s no way to insert the key. ');
    }
  }  
  iobjFor(AttachTo) remapTo(AttachTo, DirectObject, labDoorHandle)
  iobjFor(DetachFrom) remapTo(DetachFrom, DirectObject, labDoorHandle)
;

++ labDoorHandle: Attachable, Component 'steel lab door handle' 'door handle'
  "A strong-looking steel handle is welded to the laboratory door. "
  isMajorItemFor(obj) { return obj == heavyChain; }
;

++ labDoorKeyhole: Component 'keyhole/hole' 'keyhole'
  "The laboratory door has a narrow keyhole in it, just under its steel 
  handle. The keyhole is covered by a thick layer of ice. "
  dobjFor(Unlock) remapTo(Unlock, trollLaboratoryOutside)
  dobjFor(UnlockWith) remapTo(UnlockWith, trollLaboratoryOutside, IndirectObject)
  dobjFor(LookThrough) {
    action() {
      "The keyhole is covered with a thick layer of ice. ";
    }
  }
;

// Small window in lab door
++ labDoorWindow: Component 'small ice-crusted glass window' 'window'
  desc() {
    if(!isCut) {
      "The window in the laboratory door has thick layers of ice frozen onto 
      it, creating a small circle of visibility through which you can vaguely 
      discern the laboratory interior. ";
    } else {
      "A circle of glass has been cut out of the small window in the laboratory door. ";
    }
    if(agnes.isIn(trollLaboratory) && trollLaboratoryOutside.isLocked()) {
      if(isCut) {
        "\bAgnes is standing on the other side of the window. ";
      } else {
        "\bAgnes's face is at the window. She's gesticulating for you to unlock the door. ";
      }
    }
  }
  isCut = nil // cut circle yet?
  dobjFor(Open) {
    verify() { illogical('This is not the sort of window that opens. '); }
  }
  dobjFor(Close) {
    verify() { illogical('This is not the sort of window that opens. '); }
  }  
  dobjFor(Attack) remapTo(Break, self)
  dobjFor(Break) {
    verify() { 
      if(isCut) illogicalAlready('You\'ve already cut a hole in the window. ');
    }
    check()
    {
      failCheck('You try to break the window, but the glass is too thick. ');
    }
  }  
  dobjFor(Clean) {
    verify() {}
    action() {
      "You manage to remove some ice and snow from the window, but most of it 
      is frozen solid and can't be wiped off. ";
    }    
  }
  dobjFor(CutWith) {
    verify() {
      if(isCut) illogicalAlready('You\'ve already cut a circle out of the window glass. ');
      if(gIobj != glassCutter) {
        illogical('That\'s is not a suitable tool to cut the window glass with. ');
      }
    }
    check() {
      // Can't cut window when Agnes isn't stuck in the lab yet.
      if(!agnesStuckInLab.isIn(trollFrontOfBase)) {
        failCheck('That\'s an interesting idea. Maybe it will come in useful later. ');
      }
    }
    action() {
      "Using the glass cutter, you make a roughly circular cut in the window 
      glass. With the cut complete, you give the window a good bash and a 
      circular disk of glass falls to the floor inside the laboratory. 
      \b<q>Oh thank heaven for that! I'm getting all claustrophobic in here,</q> Agnes says. 
      <q>The storm blew the damn door shut so hard it triggered the lock, and I can't get
      it open.</q> ";
      agnesStuckInLab.isMuted = nil;
      if(agnesStuckInLab.isIn(trollFrontOfBase)) {
        if(agnesStuckInLab.curState == agnesStuckInLab_WantsCut) {
          agnesStuckInLab.setCurState(agnesStuckInLab_WantsKey);
        } else {
          agnesStuckInLab.setCurState(agnesStuckInLab_FindKey);
        }
      }
      isCut = true;
    }
  }
;

+ mangledLabDoor: PresentLater, Heavy 'damaged mangled broken lab laboratory window/lock/door*doors' 'laboratory door'
  desc = "Looks like Troll Station will have to requisition a new door, since this one was rather 
    badly damaged when it was pulled from of the laboratory wall. The lock is mangled and the
    door handle is gone entirely. "
  specialDesc = "The laboratory door is lying in the snow. "
  dobjFor(Open) {
    verify() { illogical('The laboratory door isn\'t actually in a wall right now. '); }
  }  
  dobjFor(Close) {
    verify() { illogical('The laboratory door isn\'t actually in a wall right now. '); }
  }  
;

// Garage door
+ trollGarageOutside: ThroughPassage -> trollGarageInside 'garage door*doors' 'garage door'
  "The garage has a wide door that can be rolled aside. At the moment, however, its rollers
  are frozen in their tracks. The door isn't completely closed though, and it looks like you 
  should be able to slip through. "
  travelBarrier = [snowMobileGarageBarrier]
  noteTraversal(travaler) { 
    "Though the garage door isn't currently open, you manage to slip through the crack between 
    the door and the wall, and into the garage. "; 
  }
  dobjFor(Open) {
    verify() { }
    check() { 
      failCheck('The door\'s rollers are frozen in their tracks. No amount of force will 
        open this door at the moment. '); 
    }
  }
  dobjFor(Close) {
    verify() { illogicalAlready('The garage door is already closed (and frozen in place to boot).'); }
  }
;

+ Enterable -> trollGarageOutside 'vehicle garage/structure' 'vehicle garage'
  "The vehicle garage is large enough to hold two medium-sized trucks and a number of smaller 
  vehicles. The building is clad with grey metal sheeting, and has a large sliding door at the 
  front. "
;

+ laboratoryBuilding: Enterable -> trollLaboratoryOutside 'laboratory/building' 'laboratory'
  "The laboratory is a small grey building, clad with aluminium siding. There's a sign on
  it that reads, unsurprisingly, <i>Laboratory</i>. "
;

