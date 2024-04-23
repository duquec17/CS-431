
sub EVENT_SAY {
    if($text=~/Hail/i) {
        if (fish == 0){
    	    quest::say("Greetings my child!");
            quest::say("I would like you to talk to one of my fans.");
            quest::say("The second one to be specific.");
            quest::say("He should tell you what to do.");
        }
        else{
            quest::say("Do you want me to bring you to him [now]?");
        }
    }
    elsif($text=~/accept/i){
    	quest::say("Bless you my child.");
    	quest::say("Chuckles is located in the Planes of Mischief");
    	quest::say("I can bring you close to him [now].");
    }
    elsif($text=~/now/i){
        quest::say("I wish you luck in your hunt.");
        $client->MovePC(126,0,0,0,0);
    }
}

sub EVENT_ITEM{
    if(plugin::check_handin(\%itemcount, 13019 => 1)) {
        $npc->SetNPCVariable("fish", 1);
        quest::say("Wonderful!");
        quest::say("We shall dine tonight!");
        quest::say("However there is a great disturbance amidst this world.");
        quest::say("The one named Chuckles, The War Crime Clown has been wreaking havoc.");
        quest::say("I want you to be the one who puts this sinner down will you [accept]?");
    }
}