#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// SAUNA
// 

trollSauna: TrollRoom 'Sauna' 'the sauna'
  "The Troll Base sauna is tiny, but with the frigid temperatures around the 
  base it must be an indispensable luxury for the researchers stationed here. 
  There is a little electric stove in the center of 
  the room, and wooden benches set against the walls surrounding it. A small 
  window in the north wall offers a view of the landscape to the north of the 
  base. A smoked glass door leads south and out to the gym. 
  <<if stove.isOn>>\bIt's rather hot here.<<end>> "
  south = doorTrollSaunaSouth
  out asExit(south)
;

+ doorTrollSaunaSouth: RoomPartItem, Door 'south smoked glass pane/door*doors' 'smoked glass door'
  "A large smoked glass pane it set in this otherwise white plastic polymer 
  door. The door is currently <<isOpen ? 'open and you can see the gym through it' : 'closed'>>. "
  specialNominalRoomPartLocation = trollSouthWall
  openStatusReportable = nil
  specialDesc = "A smoked glass door (<<isOpen ? 'standing open' : 'which is closed'>>) is set in this wall. "  
;

+ TrollNorthWindow
;

+ Chair, CustomFixture 'varnished wooden bench*benches' 'benches'
  "Varnished wooden benches are along all but the south wall of the sauna. 
  You'd think plastic would have done the job, but clearly the base designer
  thought that the sauna benches should be authentic. It's a good bet that 
  none of the researchers here ever questioned the wisdom of this. "
  isPlural = true
  cannotTakeMsg = 'The benches are fixed to the floor. '
;

// Place something on the stove to melt it.
+ stove: Switch, Surface, CustomFixture 'little electric stove' 'electric stove'
  "In somewhat of a contrast to the wooden benches, the electric stove is 
  not an authentic sauna feature. Clearly a coal burning stove would be a 
  hassle, not to mention a fire hazard. There is a switch on the side of the 
  electric stove. "
  cannotTakeMsg = 'The electric stove is integral to the sauna and fixed to the floor. '
  makeOn(val) {
    if(val) {
      "{You/he} turn{s} the electric stove on. Soon, the temperature in the sauna begins to rise. ";
    } else {
      "{You/he} turn{s} the electric stove off. After a few moments, the temperature in the sauna begins to drop. ";
    }
    inherited(val);
  }
  
;

++ Component 'switch' 'switch'
  "The small switch has an <i>on</i> and an <i>off</i> position. It's currently 
  set to <q><<stove.isOn ? 'on' : 'off'>></q>."
  dobjFor(TurnOn) remapTo(TurnOn, stove)
  dobjFor(TurnOff) remapTo(TurnOff, stove)
  dobjFor(Switch) remapTo(Switch, stove)
  dobjFor(Flip) remapTo(Flip, stove)
;
