sub EVENT_SAY {
	if($text=~/Hail/i) {
		quest::say("Hello lad");
	}
}
