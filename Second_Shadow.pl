sub EVENT_SAY {
	if($text=~/Hail/i) {
		quest::say("Greetings traveler.");
	}
}
