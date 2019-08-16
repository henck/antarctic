#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

agnes: TourGuide, Person 'attractive young woman/blonde/Agnes/Haugland' 'Agnes' // @ snowMobile
  "Tall and blonde, Agnes Haugland is an attractive young woman with Nordic
  antecedents with a face that's always ready to break into a smile. She 
  appears to be thirty-something years old. "
  isProperName = true
  isHer = true
  globalParamName = 'agnes'
  posture = sitting
;

//
// At the airstrip, Agnes is waiting for you to get on 
// the snowmobile. When you get on, she drives off to
// the south.
//
+ agnesDriving1: ActorState
  specialDesc = "{The agnes/she} is sitting on the snowmobile, waiting for you to get on. "
  stateDesc = "She's waiting for you to get on the snowmobile. "  
  isInitState = true
  beforeAction() {
    if(gActor == gPlayerChar && gActionIs(Flip) && gDobj == starterSwitch) {
      "{The agnes/she} stops you. <q>Don't do that! I like my engine hot and running.</q> ";
      exit;
    }
  }  
  afterAction() {
    if(gActor == gPlayerChar && gActionIs(SitOn) && gDobj == snowMobile) {
      "{The agnes/she} says, <q>Splendid! Let's be off, shall we?</q> With that, she 
      drives the snowmobile down the path to the south. ";
      getActor.setCurState(agnesDriving2);
      nestedActorAction(getActor, South);
      "\b{The agnes/she} raises her voice over the whine of the snowmobile's engine, 
      <q>It's a bit of a ride to Troll Base. Our airstrip is located on a piece 
      of flat land, while the base is at the foot of the Jutulsessen mountain<<gPlayerChar.setKnowsAbout(jutulsessen)>> 
      you can see on our left.</q> ";      
    } 
  }
  takeTurn() {
    inherited;
    if(!gPlayerChar.isIn(snowMobile)) "<.p>{The agnes/she} says, <q><<one of>>Hop on<<or>>Come aboard<<at random>>, and we'll get going.</q> ";      
  }
;

//
// Agnes & you arrive at fork. 
// 
+ agnesDriving2: ActorState
  stateDesc() {
    if(!gPlayerChar.isIn(snowMobile)) {
      "{The agnes/she} is waiting for you to get on the snowmobile. ";
    }
  }
  specialDesc { 
    stateDesc;
  }
  beforeAction() {
    if(gActor == gPlayerChar && gActionIs(Flip) && gDobj == starterSwitch) {
      "{The agnes/she} stops you. <q>Don't do that! I like my engine hot and running.</q> ";
      exit;
    }
  }  
  afterAction() {
    if(gActor == gPlayerChar && gPlayerChar.isIn(snowMobile)) {
      "\b{The agnes/she} says, <q>You see that hill on the left? That's our radio antenna. 
      Keeps us in touch with the rest of the world.</q><<gPlayerChar.setKnowsAbout(radioAntenna)>> ";      
      getActor.setCurState(agnesDriving3);
    }
  }
  takeTurn() {
    inherited;
    if(!gPlayerChar.isIn(snowMobile)) "<.p>{The agnes/she} says, <q>Hop on, and we'll move on before we catch a cold.</q> ";      
  }
; 

//
// Agnes & you parked at fork (2). 
// 
+ agnesDriving3: ActorState
  stateDesc() {
    if(!gPlayerChar.isIn(snowMobile)) {
      "{The agnes/she} is waiting for you to get on the snowmobile. ";
    }
  }
  specialDesc { 
    stateDesc;
  }
  beforeAction() {
    if(gActor == gPlayerChar && gActionIs(Flip) && gDobj == starterSwitch) {
      "{The agnes/she} stops you. <q>Don't do that! I like my engine hot and running.</q> ";
      exit;
    }
  }  
  afterAction() {
    if(gActor == gPlayerChar && gPlayerChar.isIn(snowMobile)) {
      "\b{The agnes/she} continues driving the snowmobile south along the snowy path. ";
      nestedActorAction(getActor, South);    
      "\b<q>Okay, here we are now. Troll Base,</q>
      {the agnes/she} says, flicking the snowmobile's cutoff switch and getting off. ";
      getActor.setCurState(agnesGuide1);
      nestedActorAction(getActor, TurnOff, starterSwitch);
      nestedActorAction(getActor, Stand);
      "\b<q>Let's leave the snowmobile here by the storage building. Zeus's armpit,
      it's cold. Come along and I'll show you inside the base.</q> ";      
      "\b{The agnes/she} walks briskly over to a snowy field in front of the base entrance 
      to the west and motions for you to follow. ";
    }
  }
  takeTurn() {
    inherited;
    if(!gPlayerChar.isIn(snowMobile)) "<.p>{The agnes/she} says, <q>Hop on, and we'll move on.</q> ";      
  }  
; 

//
// Agnes wants to guide you to front of base.
// 
+ agnesGuide1: GuidedTourState
  stateAfterEscort = agnesGuide2
  escortDest = trollFrontOfBase
  stateDesc = "She's waiting for you near the base entrance to the west. "
  specialDesc { inherited; stateDesc;} 
; 

//
// Agnes wants to guide you up the stairs.
//
+ agnesGuide2: GuidedTourState
  stateAfterEscort = agnesGuide3
  escortDest = trollStairsUp
  arrivingWithDesc = "<q>Here we are at the main building,</q> {the agnes/she} says. Motioning vaguely
    to the west, she continues: <q>We've got a garage for our vehicles and a small laboratory 
    further on. For now, let's get inside quickly and meet the chief.</q> She positions herself
    by the stairs leading up to the front door.<<gPlayerChar.setKnowsAbout(stig)>> "
  stateDesc = "She's standing here looking at you, waiting for you to follow her up the stairs. "
  specialDesc = "{The agnes/she} is standing here looking at you, waiting for you to follow her up the stairs. "
; 

//
// Agnes wants to guide you into the front door.
//
+ agnesGuide3: GuidedTourState
  stateAfterEscort = agnesGuide4
  escortDest = trollFrontDoorOutside
  arrivingWithDesc = "{The agnes/she} stamps her feet, dislodging a layer of snow stuck to her boots. She
    turns to you, <q>Right, warmth is mere steps away. Let's go inside.</q> She waits for you
    by the front door to the west. "
  stateDesc = "She's standing here looking at you, waiting for you to follow her inside. "
  specialDesc = "{The agnes/she} is standing by the front door, waiting for you to follow her inside. "
;

//
// Agnes wants to guide you into the office space.
//
+ agnesGuide4: GuidedTourState
  stateAfterEscort = agnesGuide5
  escortDest = trollDoorEastHallwayNorth
  arrivingWithDesc = "<q>So. This is Troll Base proper. It may not be big, it may 
    not be warm, it's long way from anywhere warm in fact, but we call it home. Now 
    before you get all settled in, let's first go to the commander's office and 
    say hello,</q> {the agnes/she} says. She goes over to the door to the north labelled 
    <i>Office Space</i>. "
  stateDesc = "She's standing by the door to the north, waiting for you to follow her. "
  specialDesc = "{The agnes/she} is standing by the door to the north, waiting for you to follow her. "
;

//
// Agnes wants to guide you into the commander's office.
//
+ agnesGuide5: GuidedTourState
  stateAfterEscort = agnesGuide6
  escortDest = trollDoorOfficeSpaceEast
  arrivingWithDesc = "{The agnes/she} goes over to a door to the east and knocks. <q>Come in!</q> a
    heavy voice booms from inside. Agnes motions for you to follow inside. "
  stateDesc = "She's standing by the door to the east, waiting for you to follow her inside. "
  specialDesc = "{The agnes/she} is standing by the door to the east, waiting for you to follow her inside. "
;

//
// Agnes leaves you with the professor and teleports
// to the lab.
//
+ agnesGuide6: GuidedTourState
  arrivingWithDesc() {
    "\bA tall, bearded man is standing here looking at you expectantly. 
    \bAgnes says, <q>Professor, I found this young man wandering around 
    all alone in the cold at the airstrip. Will you take him into your fold?</q> 
    <q>Ruben Larsen! <i>Velkomen</i>, I'm sure. Thanks, Agnes,</q> the bearded man booms. Agnes
    nips out the door and twiddles her fingers at you. <q>I'll be at the lab if anyone
    needs me. Ta!</q> she says and closes the door. ";
    trollDoorCommanderOfficeWest.makeOpen(nil);
    agnes.moveIntoForTravel(nil); // for now, stick Agnes in limbo.
    agnes.setCurState(agnesWaiting);
    stig.makeProper();
    "\bThe bearded man comes forward and shakes your hand. 
    \b<q>Welcome again to Troll Base. I'm Professor Berg -- call me Stig. I'm base commander 
    for the current research period, and you'll be working with me for the time being. I've
    read your thesis on amoebae in the permanent ice sheet -- very interesting.</q> 
    \bSitting down on the chair behind his desk, he adds: <q>But you must be tired. Do go 
    and drop your bag in your bedroom down the main corridor and rest up for a bit. Explore 
    the base if you like. Be careful outside, though, because there's a storm front on the way.
    Come see me later so we can get started on your project.</q> ";
  }
;

+ agnesTalking : InConversationState
  specialDesc { inherited; stateDesc; }
  stateDesc = "<<one of>>She's waiting for you to speak.
               <<or>>She's looking at you expectantly. 
               <<or>>She's waiting to see if you have more to say.<<at random>> "
  attentionSpan = 3
; 

++ agnesWaiting : ConversationReadyState
  specialDesc {inherited; stateDesc; }
  stateDesc = "She's looking around. "
; 

+ DefaultAskTopic, ShuffledEventList  
  [
    '<q>Can we talk about something else?</q> she suggests. ',
    '{The agnes/she} mutters something you don\'t quite catch. ',
    'In reply she merely cocks one eyebrow and gives an enigmatic smile. ',
    '<q>I\'m sorry,</q> she says, <q>my mind was elsewhere. Did you say something?</q> ',
    '<q>Let\'s discuss that some other time.</q> she replies. ',
    'Just at that moment, {the agnes/she} appears to be overcome by a 
     fit of coughing. ',
    'She appears not to hear you. ',
    '<q>Well,</q> she says, proceeding to give a brief reply. '
  ] 
;  

+ AskTopic @agnes
  "Agnes grins and says, <q>Me? I'm your friendly fellow researcher. 
  Outgoing, single, well-dressed and fun to be with. I like cookies,
  but not with raisins, and I enjoy boogie-woogie. Why?</q> "
;

+ AskTopic @stig
  "Agnes says, <q>He's a dear. A big and beardy dear.</q> "
;

+ AskTopic @me
  "<q>I don't know you long enough to be able to form an opinion. I'll give
  you a holler when I have one.</q> "
;

+ AskTopic @snowMobile
  "Agnes says, <q>Snowmobiles are the only way to travel in style. At least, 
  they are in this part of town.</q> "
;

+ AskTopic @jutulsessen
  "Agnes says, <q>Those mountains are known as a nunatak<<footnoteNunatak.noteRef>>. 
  They're over two kilometers tall.</q> "
;

+ AskTopic @tTrollBase
  "<q>Troll Base is our home away from home. A tiny island of civilization in 
  an endless sea of snow and ice. Stop me if I'm waxing too poetic. Love the 
  place.</q> "
;

+ AskTopic @tBeard
  "<q>Ah, the famous beard. It appears to get bigger by the month. One of these
  days Stig's going to trip over it.</q> "
;

+ AskTopic @tWeatherAlarm
  "<q>When the weather alarm sounds, everyone near the base needs to get inside 
  quickly. It's a signal that a bad front might be rolling in and you don't want
  to be caught in it.</q> "
;

+ ShowTopic @letterOpener
  "<q>Hm. I don't know much about art, but I know what I like. That isn't it, though.</q> "
;

+ AskTopic @radioAntenna
  "<q>That antenna array is a lifeline for Troll Base. Without it, we wouldn't be
  able to make contact with anyone else save by sending a pigeon.</q> "
;

+ ShowTopic @invitationLetter
  "<q>I see you come highly recommended. You should show that letter to Stig.</q> "
;
