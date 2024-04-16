sub EVENT_SAY {
	if($text=~/Hail/i) {
		quest::say("Como estas, herman?");
	}
}
