#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

stig: Person 'bearded tall middle-aged chief/man/Stig/Berg/commander/professor' 'tall bearded man' @ stigsChair
  "Large and tall, professor Stig Berg has unruly white hair and a large beard. 
  His eyes are steel blue. He appears to be about fifty years old. "
  isProperName = nil
  isHim = true
  properName = 'Professor Berg' 
  globalParamName = 'stig'
  posture = sitting
;

+ stigTalking : InConversationState
  specialDesc { inherited; stateDesc; }
  stateDesc = "<<one of>>He's waiting for you to speak.
               <<or>>He's looking at you expectantly. 
               <<or>>He's waiting to see if you have more to say.<<at random>> "
  attentionSpan = 3
; 

++ stigWorking : ConversationReadyState
  specialDesc {inherited; stateDesc; }
  stateDesc = "<<one of>>He's moving some papers around on his desk. 
               <<or>>He's scribbling something on a sheet of paper. 
               <<or>>He's scratching his beard. 
               <<or>>He's staring out the window. 
               <<or>>He's consulting a book about something.<<at random>> "
  isInitState = true
; 

// Reponse to TALK TO
+++ HelloTopic, ShuffledEventList
  [ {: "<q>Yes?</q> says {the stig/he}. " },
    {: "<q>Yes, Ruben?</q> says {the stig/he}. " },
    {: "{The stig/he} says, <q>What's on your mind, Ruben?</q> " }
  ]
;

+++ BoredByeTopic, ShuffledEventList
  [ {: "{The stig/he} goes back to his work. " },
    {: "{The stig/he} looks back at the paperwork on his desk. " }
  ]
;

//
// When you activate the weather alarm, Stig goes into this state.
// This will allow you to steal his letter opener.
//
+ stigAlarmed: HermitActorState
  step = 0
  noResponse = "{The stig/he} is too agitated to answer. "
  specialDesc() { inherited; }
  takeTurn() {
    inherited;
    switch(step++) {
      case 0: 
      "An ear-splitting alarm sounds through the base. {The stig/he} jumps up from his chair. ";
        nestedActorAction(getActor, Stand);
        break;
      case 1:
        getActor.scriptedTravelTo(trollOfficeSpace);
        "<q>Who activated the alarm?</q> he shouts. ";
        break;
      case 2:
        "{The stig/he} presses some buttons on a control panel, and the alarm goes silent. ";
        break;
      case 3:
        "{The stig/he} turns to you, <q>Sorry about all that racket. I don't know 
        whose idea of a joke this is, but the bad weather alarm is serious business.</q> ";
        break;
      case 4:
        getActor.scriptedTravelTo(trollCommanderOffice);
        break;
      case 5:
        if(gPlayerChar.isIn(stigsChair)) {
           "{The stig/he} <<one of>>frowns<<or>>glares at you<<at random>> and says, 
           <q><<one of>>Will you get off my chair, please?<<or>>That's my chair, you 
           know.<<or>>Please get off my chair, Ruben.<<at random>></q> ";
           step--;
        } else {
          nestedActorAction(getActor, SitOn, stigsChair);
          getActor.setCurState(stigWorking);
          step = 0;
        }
        break;
      default:
        break;
    }
  }
;

+ DefaultAskTopic, ShuffledEventList  
  [
    '<q>How about we talk about something else?</q> he suggests. ',
    '{The stig/he} mumbles something you can\'t quite make out. ',
    '{The stig/he} merely raises his eyebrows. ',
    '<q>I\'m sorry,</q> he says, <q>I was distracted there for a moment. What did you say?</q> ',
    '<q>Let\'s talk about that later,</q> he replies. ',
    '{The stig/he} sneezes. ',
    'He appears not to have heard you. ',
    '<q>You see,</q> he says, and starts saying something before becoming distracted. '
  ] 
;  

+ AskTopic @stig
  "<q>I've been commander of Troll Base for almost six months now. Although 
  the reseach we do is fantastic, I confess I'll be glad when it's time to get 
  back to Norway. The cold gets in my bones, you know.</q> "
;

+ AskTopic @agnes
  "<q>Everyone likes Ms Haugland. She has a sense of humor that keeps base 
  morale up and she's an excellent scientist to boot. I don't know what we'd 
  do without her.</q> ";
;

+ AskTopic @me
  "<q>You're the new guy, so give me a while to get to know you. Impress me
  with good science, and you'll be in my good book.</q> "
;

+ AskTopic @tBeard
  "{The stig/he} blinks. <q>Some people have beards, son. Try growing one. 
  It'll keep your face warm. </q> "
;

+ AskTopic @tTrollBase
  "{The stig/he} says, <q>Troll Base has been around since 1990. It was a 
  summer-only research station then, you know, and much smaller. I came down 
  for a few spells in the early days, and it was only five of us here.
  \bThe base was made much bigger in 2005 and we actually use the old base 
  as a storage facility now. We can now accommodate sixteen people, plus we 
  get to stay here year-round. Still, polar winters aren't my favorite time 
  of year.</q> "
;

+ AskTopic @snowMobile
  "<q>You'll find our snowmobiles are a godsend for getting around the area. 
  You wouldn't get very far on foot in the snow.</q> "
;

+ AskTopic @letterOpener
  "<q>It's a souvenir I picked up when I was in Hammerfest<<footnoteHammerfest.noteRef>>. 
  I wanted to see the Aurora Borealis, you see. Stayed there for two weeks 
  and didn't see a thing.<q> "
; 

+ ShowTopic @letterOpener
  "{The stig/he} frowns. <q>That's an interesting letter opener. I have one 
  just like it.</q> "
;

+ GiveTopic @letterOpener
  "<q>You're very kind, but I already have one just like it.</q> "
;

+ footnoteHammerfest: Footnote
  "Hammerfest is one of the northernmost towns in Norway. "
;

+ AskTopic @tWeatherAlarm
  "<q>We sound the weather alarm when a sudden change in the weather 
  necessitates that all researchers return to base immediately. 
  Sometimes we get news of an unexpected storm rolling in and we can't 
  afford anyone to be caught in it.</q> "
;

+ AskTopic @jutulsessen
  "<q>The Jutulsessen mountains are a so-called nunatak, a glacial island in 
  the ice sheet. They make a great reference point, since they're over two 
  kilometers tall, you see.</q> "
;

+ AskTopic @radioAntenna
  "<q>Our radio tower is located on top of one of the outlying foothills of 
  the Jutulsessen mountains.</q> "
;

+ ShowTopic @invitationLetter
  "Professor Berg say, <q>Yes, I was contacted by NILU two weeks ago to 
  prepare for your arrival. Not to worry, you are most welcome here.</q> "
;
