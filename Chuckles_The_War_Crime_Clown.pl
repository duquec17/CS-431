# Part 7 of Grand Quest:
# [Jesus] & The Shadow Wizard Money Fans Face Chuckles

# Spawn Event to work behind the scenes
sub EVENT_SPAWN {
	# Illusion spell that changes model and buffs him
	# Makes him look like Jester
	$npc->CastSpell(32200, $npc);

	# Checks HP percentange for next major spell
	quest::setnexthpevent(75);
}

# Event Handler for Spells based on HP percentage (Spells NOT Working, ONLY messages)
sub EVENT_HP {
	# Cast Gravity Flux on attacker at 75 percent HP
	if ($hpevent == 75) {
		$npc->CastSpell(73, $userid);  # NEEDS FIXING
		
		# Insults Chuckles makes to player
		quest::say("DON'T YOU KNOW WE ALL FLOAT DOWN HERE!?");

		# Double check to ensure lock on to target again
		quest::attack($name);

		# Sets new HP event to occur at 50%
		quest::setnexthpevent(50);
	}

	# Cast Color Skew on attacker at 50 percent HP
	if ($hpevent == 50) {
		$npc->CastSpell(178, $userid); # NEEDS FIXING

		# Insults Chuckles makes to player (Working)
		quest::say("Oh come on, I saw more colorful explosions back the Clown War 2. Now those were some fun times.");
		
		# Double check to ensure lock on to target again
		quest::attack($name);

		# Sets new HP event to occur at 25%
		quest::setnexthpevent(25);
	}
	
	# Cast Berserker Spirit on attacker at 25% percent HP
	if ($hpevent == 25) {
		$npc->CastSpell(176, $userid);  # NEEDS FIXING

		# Insults Chuckles makes to player
		quest::say("THAT'S IT I'M GOING FOR THE EMOTIONAL DAMAGE!");
		quest::say("You are ugly.");

		# Double check to ensure lock on to target again (Possibly need to remove)
		quest::attack($name);
	}
}

#7 Interactions with Chuckles, The War Crime Clown (100% operational)
sub EVENT_SAY {
	if($text=~/Hail/i) {
		# Introduction 
		quest::say("Hehe! If it ain't a wannabe adventurer, gods you smell rancid");
		quest::say("Who have you been around to get you smelling like my toilet after I get TacoBell?");
		
		# Illusion spell that changes model and buffs him
		# Makes him look like Jester
		$npc->CastSpell(32200, $npc);

	#7.1 Chuckles will begin by listing off a number of his crimes
	}elsif($text=~/Jesus sent me/i) {
		quest::say("Ugh, that nerd needs to get a 3 third life.");
		quest::say("So I brought mustard gas instead of Honey mustard to the party, EXCUSE MY POOR HEARING!");
		quest::say("No, I bet he's still complaining about the child soldiers. They said they wanted to leave the sweatshops, but that's my dime they're wasting.");

	#7.2 When any comment is made to besides desied interactions he will become hostile
	}else {
		quest::say("Well, I've got news for you, sunshine! I don't care what you or any carpenter says. I'm not getting pushed off the stage anytime soon.");
		quest::attack($name);
	}
}

# Death Interaction (100% Working)
sub EVENT_DEATH_COMPLETE {
	quest::emote("'s corpse tries to mumble one last horrifying joke before falling over dead with a twisted smile.");
	quest::summonitem(106620);
}
