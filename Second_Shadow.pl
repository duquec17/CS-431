sub EVENT_SAY {
	if($text=~/Hail/i) {
		quest::say("Greetings traveler.");
		quest::say("Say do you have a taste for [fish]?");
	}
	elsif($text=~/fish/i){
	    quest::say("Wonderful!");
	    quest::say("Here take this fishing rod!");
	    quest::summonitem(13100);
	    quest::say("And you will need [bait] too.");
	}
	elsif($text=~/bait/i){
	    quest::summonitem(13101, 30);
	    quest::say("Now those fish won't catch themselves!");
	    quest::say("If they do you won't be the one getting them!");
	}
}
sub EVENT_ITEM{
    if(plugin::check_handin(\%itemcount, 13019 => 1)) {
        quest::say("Ah, thank you for this fish!");
        quest::say("Now what was I doing?");
        plugin::return_items(\$itemcount);
        quest::say("Now return to Jesus to give him this fish.");
    }
    else{
        quest::say("Neat item you have here!");
        quest::say("You have any fresh fish?");
        plugin::return_items(\$itemcount);
    }
}