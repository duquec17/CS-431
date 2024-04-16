#First_Shadow  Script
#
#Simplified Algorithm
#1. When hailed by player will ask for password
#2. Check if password given is correct
#	2.0.1. If correct give player next Grand Quest step (Collect remains)
#	2.0.2. If incorrect player will be teleported back to nexus
#3. Assign player collect drop from rare creature in the area (East common lands)
#4. Check item given by player
#	4.0.1. If correct will give player next Grand Quest step
#	4.0.2. If incorrect will repeat what drops are viable and return item back to player
#5. Teleport player to Dessert of Ro
#
#1. When hailed by player will ask for password
sub EVENT_SAY {
if($text=~/Hail/i) {
	
	#Greeting to player
	quest::say("Hello there adventurer, I'm sorry but I can't talk.");
	quest::say("I'm waiting to receive a important message, do you have it?");
}
elsif($text=~/Cervezas por mis hermanos/i) {
	quest::say("Ah gracias hermano");
}
}
