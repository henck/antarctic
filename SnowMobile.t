#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>


/*
 *   This barrier can be placed on connections to guarantee that one can only
 *   pass on a snowmobile.
 */
distanceBarrier: TravelBarrier
  canTravelerPass(traveler) { return traveler == snowMobile; }
  explainTravelBarrier(traveler)
  {
    "Walking along this path on foot to get anywhere would take too long, and
    prolonged exposure to the intense cold would be very dangerous.
    You decide that it's best to turn back. ";
  }
;

/*
 *   This barrier can be placed on connections to guarantee that a snowmobile
 *   cannot pass.
 */
snowMobileStandardBarrier: VehicleBarrier
  explainTravelBarrier(traveler) {
    reportFailure('You can\'t ride the snowmobile into there. ');
  }
;   

snowMobileSteepBarrier: VehicleBarrier
  explainTravelBarrier(traveler) {
    reportFailure('The incline is steep and strewn with shale and rocks. You can\'t drive the snowmobile up there. ');
  }
;   

snowMobileGarageBarrier: VehicleBarrier
  explainTravelBarrier(traveler) {
    reportFailure('You will need to open the garage door first in order to drive the snowmobile into the garage. ');
  }
;  



snowMobile: Attachable, Vehicle, Chair, Heavy 'two-seater snowmobile/mobile' 'snowmobile' @ trollFrontOfBase // trollAirstrip
  "Remeniscent of a large motorbike set on a pair of skis, the snowmobile
  has seats for two people, one behind the other. There are handlebars at the
  front, in the centre of which is mounted the starter button and a small switch. "
  specialDesc = "The two-seater snowmobile rests on the ground. "
  initSpecialDesc = "A two-seater snowmobile stands at the end of the airstrip. "
  useSpecialDesc = (!gPlayerChar.isIn(self))
  engineOn = true
  travelerPreCond(conn) { return [snowEngineOn]; }
  bulkCapacity = 20  
  isMajorItemFor(obj) { return obj == heavyChain; }
;

+ Button, Component 'starter button' 'starter button'  
  "It's a small round button used for starting the snowmobile's engine. "
  dobjFor(Push)
  {
    verify() {
      if(snowMobile.engineOn)
        illogicalNow('The snowmobile\'s engine is already running. ');
    }
    check() {
      if(!starterSwitch.isOn)
        failCheck('Nothing happens. ');
    }
    action() {
      "The snowmobile's engine starts up. ";
      snowMobile.engineOn = true; 
      engineNoise.makePresent();      
    }    
  }   
;

+ starterSwitch : Switch, Component 'small black switch/engine' 'small switch'
  "It's a small black switch mounted at the centre of the handlebars, next
  to the button. "
  isOn = true
  makeOn(val) {
    inherited(val);
    if(val == nil && snowMobile.engineOn)
    {
      "The snowmobile engine lapses into silence. ";
      snowMobile.engineOn = nil;
      engineNoise.makePresentIf(nil);
    }
  }
  verifyDobjListenTo { logicalRank(50, 'silent'); }
  soundDesc = "The engine is currently silent. "
;

+ engineNoise: PresentLater, SimpleNoise 'engine/noise' 'engine'
  "The snowmobile engine is purring quietly as it ticks over. "
  isAmbient = nil
  initiallyPresent = true
;

+ Component 'handlebar*handlebars' 'handlebars'
  "The handlebars have comfortable rubber grips to make for safer steering. "
  isPlural = true
;

+ Component 'seat*seats' 'seats'
  "The snowmobile seats are made from artificial leather. "
  isPlural = true
;

snowEngineOn : PreCondition
  checkPreCondition(obj, allowImplicit) { 
    if(!snowMobile.engineOn)
    { 
      reportFailure('The snowmobile doesn\'t budge. ');
      exit;
    } 
    else if(obj.travelBarrier.indexOf(snowMobileStandardBarrier) == nil 
         && obj.travelBarrier.indexOf(snowMobileSteepBarrier) == nil
         && obj.travelBarrier.indexOf(snowMobileGarageBarrier) == nil)
      "The snowmobile <<one of>>emits a healthy roar from its engine as it 
      sets off<<or>>slides smoothly through the snow<<at random>>. ";
  }
;
