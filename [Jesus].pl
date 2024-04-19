#[Jesus] magic tricks
#
#Simplified Algorithm 
#1. Start
#2. NPC initialization
#3. Event Handling:
#	a. Wait for an event trigger
#	b. If triggered event is a player's interaction
#4. Event Handlers:
#	a. Hail Event Handler
#	b. Item Hand-in Handler
#	c. Item Summon Event Handler
#	d. Buff Spell Request Event Handler
#	e. Port player to specific zone Event Handler
#	f. Convert water to Health potion Event Handler
#5. Return Items:
#6. End


#1. Start
#2. NPC Initialization
sub EVENT_SAY {

#3.Event Handlers
#3a. Triggers for event handlers
if($text=~/Hail/i) {
	quest::say("Hola hermano, how can I help");
	
	#Selectable events
	quest::say("[Level up]");
	quest::say("[A.Adv.]");
	quest::say("[Summon Item]");
	quest::say("[Need buff]");
	quest::say("[Port]");
	quest::say("[Perform a magic trick]");
	quest::say("[Grand Quest]");
	} 

	#4. Event Handlers
	elsif($text=~/Level up/i) { #a. Level up Handler
		quest::say("Given me 10,000 plat");
	}
	elsif($text=~/A.Adv./i) { #b. Alt Level up Handler
		quest::say("Give me 5,000 plat");
	}
	elsif($text=~/Summon Item/i) { #c. Summon item Handler
		quest::say("For a diamond I can get you any item you want.");
		quest::say("First tell me the ID number and then give me the diamond.");
	}
	elsif($text=~/Need buff/i) { #d. Buff request Handler
		quest::say("Select a buff");
		quest::say("[Divine strength]");
		quest::say("[Divine Aura]");
	}
	elsif($text=~/Port/i) { #e. Port request Handler
		quest::say("Select a zone to travel to");
		quest::say("[Kurn]");
		quest::say("[Planes of Knowledge]");
		quest::say("[common lands]");
	}
	elsif($text=~/Perform a magic trick/i) { #f. Convert water to Health potion Handler
		quest::say("I'll need some [Sweetwater] first, but let's see what I can muster");
	}
	elsif($text=~/Grand Quest/i) {
		quest::say("Ah, so you're ready to face some of the hardest challenges?");
		quest::say("Then go to the [common lands] and speak the password to my follower");
		quest::say("The password is, 'Cervezas por mis hermanos.'");
		if($client->GetLevel() <= 20) {
			my $lvlVal = $client->GetLevel();
			quest::level($lvlVal + 10);
		}
	}
###

###
#d. Buff request code (100% Functional)
	if($text=~/Divine strength/i) {
		quest::say("A bit of divinity will help");
		$npc->CastSpell(1456, $userid);
	}
	elsif($text=~/Divine Aura/i) {
		quest::say("Like the div?");
		$npc->CastSpell(10, $userid);
	}
###

###
#e. Port request code (100% Functional)
	if($text=~/Kurn/i) {
		quest::say("Seeya");
		$client->MovePC(97,0,0,0,0);
	}
	elsif($text=~/Planes of Knowledge/i) {
		quest::say("Seeya");
		$client->MovePC(202,0,0,0,0);
	}
	elsif($text=~/common lands/i) {
		quest::say("Seeya");
		$client->MovePC(22,0,0,0,0);
	}
###
}
#End of First EVENT_SAY

###
#a. Level up (Normal) code (100% Functional)
#b. Give AA for money (100% Functional)
#c. Summon Item Code (100% Functional) 
#f. Convert water to wine code (100% Functional)
sub EVENT_ITEM {
	# Check if the item received is a Flask of sweetwater
	if(plugin::check_handin(\%itemcount, 3646 => 1)) {
		#if given correct item
		quest::say("Ah, gracias hermano for the water. Alright, here ya go.");
		quest::summonitem(13052); # Reward given
	}
	elsif($platinum == 10000) {
		quest::say("Quieres mas?");
		my $lvlVal = $client->GetLevel();
		quest::level($lvlVal + 1);
	}
	elsif($platinum == 5000) {
		#Checks to see if player is level 52
		if($client->GetLevel() >= 52) {
			quest::say("Feel stronger?");
			$client->AddAAPoints(10);
		}
		else {
			quest::say("you got the cash, but aren't ready so get stronger.");
			plugin::return_items(\$itemcount);
		}
	}
	elsif(plugin::check_handin(\%itemcount, 10037 => 1)) {
		quest::say("Thanks for the diamond and here ya go");
		if($text=~/\d{0,9}/) {
			quest::summonitem("$text");
		}
	}
	# Return item if not correct
	else {
		quest::say("Wrong thing buddy.");
		plugin::return_items(\%itemcount);
	}
}
###

#END of FILE Zone: Nexus ID: NEEDED (numbers) -- NAME:[Jesus] (Yes, [ ] included)
