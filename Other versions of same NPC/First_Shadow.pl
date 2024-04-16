sub EVENT_SAY {
	if($text=~/Hail/i) {
		quest::say("Hello traveler have you spoken with [Jesus]");
	}
}
