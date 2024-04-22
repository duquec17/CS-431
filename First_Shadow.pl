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
sub EVENT_SPAWN{
    $npc->SetNPCVariable("Accepted", 0);
}

sub EVENT_SAY {
if($text=~/Hail/i) {
	
	#Greeting to player
	quest::say("Hello there adventurer, I'm sorry but I can't talk.");
	quest::say("I'm waiting to receive a important message, do you have it?");
}
elsif($text=~/Cervezas por mis hermanos/i) {
	quest::say("Ah gracias hermano");
	quest::say("So you are the one that [Jesus] has trusted.")
	quest::say("However you will still need to prove that you can be trusted with the task!")
	quest::say("Bring me thine body of a man that call the hills thine place of rest!");
	quest::say("Do you [accept]?");
}
elsif($text=~/accept/i){
quest::say("Very well, I will await your return.")
    $npc->SetNPCVariable("Accepted", 1);
}
else{
    quest::say("Begone from my sight!");
    $client->MovePC(152,0,0,0,0);
}
}

sub EVENT_ITEM{
my $visited = $npc->GetNPCVariable("Accepted");
if (Accepted == 1) {
    if(plugin::check_handin(\%itemcount, 16539 => 1)) {
        quest::say("I see you have slain the hill giant and brought back all that remains of him!");
        quest::say("You have proven yourself worthy of the task of heroes.")
        quest::say("Speak to the one of sand and he will guide you to your next step!")
        quest::say("Fair well and may God be with you!")
        if($client->GetLevel() > 40){
            quest::level(40);
        }
        $client->MovePC(35, -1500, -2500, 0);
    }
    else{
        quest::say("This is not what I seek from you. I want not this ... Thing.")
        quest::set("Return to me once you have slain and recived the man of the hill's corpse.")
        plugin::return_items(\$itemcount);
    }
}
else{
    quest::say("What?")
    quest::say("Why have you given me this?")
    quest::say("I have no desire for it. leave me if you are only to waste my time.")
    plugin::return_items(\$itemcount);
}
}