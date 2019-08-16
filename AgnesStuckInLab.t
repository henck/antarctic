#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

agnesStuckInLab: Person 'attractive young woman/blonde/Agnes/Haugland' 'Agnes' @ trollFrontOfBase
  desc() { agnes.desc(); }
  isProperName = true
  isHer = true
  globalParamName = 'agnes'
  posture = standing
  cannotTakeMsg = 'You can\'t reach her from here. '
  cannotKissActorMsg = 'You can\'t reach her from here. '
  uselessToAttackMsg = 'You can\'t reach her from here. '
  isMuted = true // unmute as soon as glass is cut
;

+ agnesStuckInLab_Init : ActorState, CyclicEventList
  specialDesc = "Agnes's face is pressed against the window in the laboratory door. "
  stateDesc = "She has her nose pressed against the window in the laboratory door. "  
  isInitState = true
  eventList = [
    {: "<.p>{The agnes/she} taps frantically on the window, gesticulating for you to 
      unlock the laboratory door.<<gPlayerChar.setKnowsAbout(labKey)>> " },
    {: "<.p>{The agnes/she} taps the window glass. Her lips move, but
      you can't quite make what she is saying. Something about a key and <q>Jacques</q>.<<gPlayerChar.setKnowsAbout(labKey)>> " }
  ]
;

++ ShowTopic @labKey
  "{The agnes/she} looks at the key and nods vigorously. ";
;

+ agnesStuckInLab_WantsCut : ActorState, CyclicEventList
  specialDesc = "Agnes's face is pressed against the window in the laboratory door. "
  stateDesc = "She has her nose pressed against the window in the laboratory door. "  
  eventList = [
    {: "<.p>{The agnes/she} pummels frantically on the window. " },
    {: "<.p>{The agnes/she} taps the window glass and shakes her head. She's making
        a series of complicated gestures. It's hard to understand what she's suggesting.
        Either she wants you to force the door or break the glass, it seems. " }
  ]
;

++ ShowTopic @labKey
  "{The agnes/she} looks at the key balefully. ";
;

+ agnesStuckInLab_FindKey : ActorState, CyclicEventList
  specialDesc = "Agnes's face is at the circle you cut in the window in the laboratory door. "
  stateDesc = "She has her face at the circle you cut in the window in the laboratory door. "  
  activateState (actor, oldState) {
    "<.p><<if labKey.seen>>{The agnes/she} says, <q>Please try and unlock this 
    door with the laboratory key.</q><<else>>{The agnes/she} says, <q>
    Please see if you can find the laboratory key so we can unlock
    this door.</q><<end>><<gPlayerChar.setKnowsAbout(labKey)>> ";
  }
  eventList = [
    nil,
    {: "<.p>{The agnes/she} is pacing behind the laboratory door. " },
    {: "<.p>{The agnes/she} looks at you expectantly. " }
  ]
;

++ ShowTopic @labKey
  "Agnes says, <q>Good, that's the right key. Now see if you can unlock this door!</q> ";
;

++ AskTopic, SuggestedAskTopic, ShuffledEventList @labKey
  name = 'the laboratory key'
  isActive = (!labKey.seen)
  eventList = [ {: "{The agnes/she} says, <q>Please try and find the lab key. I think Jacques had it last.</q> " },
    {: "<q>I think Jacques has the lab key somewhere. Maybe it's in his room,</q> says {the agnes/she}. " }
  ]
;

++ AskTopic, SuggestedAskTopic, ShuffledEventList @labKey
  name = 'the laboratory key'
  isActive = labKey.seen
  eventList = [ {: "{The agnes/she} says, <q>You found it, right? So please unlock the blessed door.</q> " },
    {: "{The agnes/she} says, <q>What are you waiting for? Unlock the door already!</q> " }
  ]
;

+ agnesStuckInLab_WantsKey: ActorState, CyclicEventList
  specialDesc = "Agnes's face is at the circle you cut in the window in the laboratory door. "
  stateDesc = "She has her face at the circle you cut in the window in the laboratory door. "  
  activateState (actor, oldState) {
    "<.p>{The agnes/she} says, <q>Oh come on. Here, let me have the key so I can try to unlock it from the inside.</q> ";
  }
  eventList = [
    nil,
    {: "<.p>{The agnes/she} is pacing behind the laboratory door. " },
    {: "<.p>{The agnes/she} looks at you expectantly. " }
  ]
;

++ AskTellShowTopic, ShuffledEventList @labKey
  [ {: "{The agnes/she} says, <q>Give me the key, and I'll try to unlock the door from the inside.</q> " },
    {: "{The agnes/she} holds our her hand through the window. <q>Hand me the key, I want to see if I can get this door open from the inside.</q> " }
  ]
;

+ agnesStuckInLab_WantsViolence: ActorState, CyclicEventList
  specialDesc = "Agnes's face is at the circle you cut in the window in the laboratory door. "
  stateDesc = "She has her face at the circle you cut in the window in the laboratory door. "  
  activateState (actor, oldState) {
    "<.p><q>Thanks. Now let me see if I can get this door unlocked from the inside.</q> ";
    gDobj.moveInto(nil);
    "\bYou hear scratching sounds as {the agnes/she} tries to insert the key in the 
    laboratory door lock on the inside. <q>Damn it! It won't go in! The lock's full of ice.</q>
    \b{The agnes/she} goes quiet for a bit. Then she says, <q>Okay, the lock's out then.</q> 
    She rummages in her coat pocket and produces a key.
    \bHanding the key to you, she says <q>Here, take this key to the storage building and see 
    what you can find to help us out. I sure hope that lock works.</q> ";
    storageKey.moveInto(me);
  }
  eventList = [
    nil,
    {: "<.p>{The agnes/she} is pacing behind the laboratory door. " },
    {: "<.p>{The agnes/she} looks at you expectantly. " },
    nil
  ]
;

++ AskTellShowTopic, ShuffledEventList @labKey
  [ {: "{The agnes/she} says, <q>The key's useless. We've got to find another way to get this door open.</q> " },
    {: "{The agnes/she} says, <q>Too bad the lock's frozen solid.</q> " }
  ]
;


//
// These topics are active while Agnes is behind the unbroken window.
// 

+ TopicGroup
  isActive = agnesStuckInLab.isMuted;
;

++ HelloTopic, ShuffledEventList
  [ {: "{The agnes/she} indicates that she can't hear you through the window glass. " },
    {: "{The agnes/she} places her hand behind her ear and shrugs. " }
  ]
;

++ DefaultAskTopic, ShuffledEventList
  [ {: "{The agnes/she} indicates that she can't hear you through the window glass. " },
    {: "{The agnes/she} places her hand behind her ear and shrugs. " }
  ]
;  

++ DefaultGiveTopic
  "The window glass is in the way. "
;  

++ ShowTopic @glassCutter
  "{The agnes/she} looks at the glass cutter. Then she taps the window glass and makes a cutting motion. ";
;

++ ShowTopic @heavyChain
  // To show the chain, you'll have to untie it first. Therefore there are no
  // responses for the chain while tied. 
  "{The agnes/she} looks at the heavy chain and shrugs. ";
;

//
// These topics are active after then window is broken and Agnes can hear you
// and speak to you.
// 

+ TopicGroup
  isActive = !agnesStuckInLab.isMuted;
;

++ HelloTopic, ShuffledEventList
  [ {: "<q>Hello? Yes?</q> says {the agnes/she}. " },
    {: "<q>What is it?</q> asks {the agnes/she}. " }
  ]
;

++ DefaultAskTopic, ShuffledEventList  
  [
    '<q>Oh please get a move on! I want to get out of here,</q> she says. ',
    '{The agnes/she} mutters something you don\'t quite catch. '
  ] 
;  

++ GiveTopic @labKey
  topicResponse
  {
    getActor.setCurState(agnesStuckInLab_WantsViolence);
  }   
;

++ AskTellShowTopic, StopEventList @glassCutter
  [ {: "{The agnes/she} says, <q>That was a bright idea. I'm still rather 
    stuck in here though.</q> " },
    {: "{The agnes/she} smiles wrily. <q>Yes, yes, after I get out of here
    I'll be sure to give you a pat on the shoulder.</q> " }
  ]
;

++ AskTellShowTopic, StopEventList @heavyChain
  [ {: "{The agnes/she} says, <q>We use that chain to tow vehicles. Hey, are you 
    thinking what I'm thinking?</q> " },
    {: "{The agnes/she} asks, <q>You think you can pull the door loose with that chain?</q> " },
    {: "{The agnes/she} observes, <q>You'd need a lot of force to pull the door off with that chain.</q> " }
  ]
;

++ AskTellShowTopic, StopEventList @storageKey
  [ {: "<q>That's they key to the storage building. Please go see what you can find
     in there to help us out.</q> " }, 
    {: "{The agnes/she} says, <q>Use that key to go into the storage building. There
    must be something in there we can use to get this door open.</q> " }
  ]
;

++ AskTellTopic @tJacques
  topicResponse() {
    "{The agnes/she} says, <q>Jacques is one our researchers here. He's the
    one who mostly manages this lab. ";
    if(!labKey.seen) {
      "I'm pretty sure he must have the key somewhere.";
    }
    "</q> ";
  }
;

