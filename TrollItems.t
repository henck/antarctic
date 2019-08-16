#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// Your satchel
//
satchel: Wearable, OpenableContainer 'leather satchel/pack/backpack/bag/rucksack' 'satchel' @ me
  "You've had this leather satcher for years. Though it's slightly worn now, 
  you've never seen the need to replace it. The satchel's flap is <<isOpen ? 'open' : 'closed'>>. "
  wornBy = me
  owner = me
  openStatusReportable = nil
  bulkCapacity = 20
;

//
// NILU invitation letter. It's in your satchel.
//
+ invitationLetter: Readable 'letter' 'letter'
  "This is a letter you received from the Norwegian Institute for Air Research, on of the
  leading scientific research laboratories in Europe. You've read it many times and know it 
  by heart. "
  readDesc = "The letter reads,
    \b<b>Norsk Institutt for Luftforskning (NILU)
    \nKjeller, Oslo</b>
    \bDear Mr Larsen,
    \bIt is with pleasure that we approve your request for conducting research at our
    antarctic research station Troll Station, to further your thesis titled <i>Amoebae 
    in statis in the permanent ice sheet</i>.
    \bAll travel arrangements have been made in your name. Please report to Dr Stig Berg
    on arrival.<<gPlayerChar.setKnowsAbout(stig)>>
    \b(The letter goes on to detail your travel arrangements.) ";
;


//
// Letter opener
// You can use it to pry open a desk drawer.
//
letterOpener: Thing 'pewter letter opener' 'letter opener' @ stigsDesk
  "The letter opener is made of pewter, rather dull, and a little troll is engraved in the handle. "
  // You can pry things (open) with this:
  iobjFor(PryWith) {
    verify() {}
  }
  // You can't take the opener from the desk while Stig is in his office.
  // You must lure him away by making a lot of noise in the next room.
  dobjFor(Take) {
    check() {
      if(!self.moved && stig.isIn(trollCommanderOffice)) {
        failCheck('Professor Berg sees you reaching for the letter opener on his 
          desk and stops you. <q>Please don\'t touch that. I\'m quite attached to it, 
          you know.</q> '); 
      }
    }
  }
;

//
// lab key. It's in Jacques' drawer
//
labKey: Key 'steel lab laboratory key' 'laboratory key' @me // @jacquesDrawer
  "It's a small steel key labelled <i>Laboratory</i>. "
;

// 
// Key to the storage building
//
storageKey: Key 'steel storage key' 'storage key'
  "It's a small steel key to the storage building. "
;

// 
// Glass cutter. Allows you to cut the glass
// in the laboratory door.
// 
glassCutter: Thing '(glass) cutter' 'glass cutter' @ me
  "It's a small steel knife for cutting panes of glass. "
  iobjFor(CutWith) {
    verify() {
      if(gDobj == glassCutter) illogicalSelf('The glass cutter can\'t cut itself. ');
    }
    check() {
      if(gDobj != labDoorWindow) failCheck('The glass cutter only works on glass. ');
    }
  }
;

// Heavy chain
heavyChain: Attachable, Thing 'heavy strong chain' 'heavy chain' @ me // trollStorage
  "This is a length of strong chain, about six meters of it. It seems to
  be useful for towing stalled vehicles. "
  specialDesc() {
    if(isAttachedTo(labDoorHandle)) "There's a heavy chain here, attached to the handle of the laboratory door. ";
    else if(isAttachedTo(snowMobile)) "There's a heavy chain here, attached to the back of the snowmobile. ";
    else if(isAttachedTo(labDoorHandle) && isAttachedTo(snowMobile)) "There's a heavy chain here, attached to the handle of the laboratory door and the back of the snowmobile. ";
  }
  useSpecialDesc() {
    return isAttachedTo(labDoorHandle) || isAttachedTo(snowMobile);
  }
  canAttachTo(obj) { 
    return obj == labDoorHandle || obj == snowMobile; 
  }
  handleAttach(other) {
   if(self.location != me.location) {
      "You drop the chain on the ground first, then tie it to <<other.theName>>. ";
      self.moveInto(me.location);
    } else if(other == labDoorHandle) {
      "You wrap the end of the chain securely around the laboratory door handle. ";
    } else if(other == snowMobile) {
      "You tie the end of the chain to the back of the snowmobile. ";
    }
  }
  handleDetach(other) {
    if(other == labDoorHandle) {
      "You untie the chain from the laboratory door handle. ";
    } else if(other == snowMobile) {
      "You untie the chain from the back of the snowmobile. ";
    }    
  }
  travelWhileAttached(movedObj, traveller, connector) {
    // If attached to door handle, then chain is dropped on ground.
    if(isAttachedTo(labDoorHandle)) {
      "The heavy chain is tied to the door handle, so you drop it on the ground. ";
      self.moveInto(trollFrontOfBase);
    }
    else if(isAttachedTo(snowMobile) && !me.isIn(snowMobile)) {
      "The heavy chain is tied to the snowmobile, so you drop it on the ground. ";
      self.moveInto(trollFrontOfBase);
    }
  }
  moveWhileAttached(movedObj, newCont) {
    if(movedObj == snowMobile) {
      if(heavyChain.isAttachedTo(labDoorHandle)) {
        "You gun the engine of the snowmobile. As it shoots forward, the chain is lifted off the
        ground and then stretched taut. With a rumpling sound, the entire laboratory door is ripped
        from the wall.
        \bWith a jerk, the chain comes loose from the door handle and swishes through the air. It
        lands in the snow next to the snowmobile, missing you narrowly. ";
        heavyChain.detachFrom(labDoorHandle);
        heavyChain.moveInto(newCont);
        trollLaboratoryOutside.moveInto(nil);
        trollLaboratoryInside.moveInto(nil);
        laboratoryBuilding.destination = trollLaboratory;
        mangledLabDoor.makePresent();
        trollFrontOfBase.west = trollLaboratory; 
        trollLaboratory.travelBarrier = [snowMobileStandardBarrier];
        trollLaboratory.east = trollFrontOfBase;
        addToScore(5, 'busting the laboratory door ');
        "\b<q>Free! Free! Thank you, my savior!</q> Agnes cries as she comes stumbling out of 
        the laboratory. ";
        agnesStuckInLab.moveIntoForTravel(nil);
        agnes.moveIntoForTravel(trollFrontOfBase);
        // TODO What state is Agnes in now?
      } else {
        // snowmobile drags chain
        "The heavy chain is dragged behind the snowmobile. ";
        heavyChain.moveInto(newCont);
      }
    }
  }  
  dobjFor(Take) {
    check() {
      if(isAttachedTo(labDoorHandle)) failCheck('You\'ll have to untie the chain from the door handle first. ');
      if(isAttachedTo(snowMobile)) failCheck('You\'ll have to untie the chain from the snowmobile first. ');
    }
  }
  dobjFor(Pull) {
    action() {
      if(isAttachedTo(labDoorHandle) || isAttachedTo(snowMobile)) {
        "You pull hard on the chain, but it doesn't budge. ";
      } else { inherited; }
    }
  }
  // Cannot attach/detach while sitting on snowmobile
  dobjFor(AttachTo) {
    preCond = [actorStanding]
  }
  dobjFor(DetachFrom) {
    preCond = [actorStanding]
  }
;
