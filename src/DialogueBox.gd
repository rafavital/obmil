extends Control

export (String, FILE, "*.json") var dialogue_file_path : String

onready var text = $UIElements/DialogueText
onready var show_tween = $ShowDialogueTween
onready var ui_elements = $UIElements
onready var audio = $AudioStreamPlayer

var dialogue_finished := false
var current_dialogue : String
var rng = RandomNumberGenerator.new()

var dial = {
	"0" : "I'm nervous about failing in Pre-Calculus.",
	"1" : "My unhappiness is beginning to suffocate me and I feel like there is no chance of recovery at this point.",
	"2" : "Feeling dead inside, empty and numb isn't always bad, especially when something bad happens you just shrug it off and move on.",
	"3" : "It's been 5 years since we talked and we looked into each other's eyes and I still remember how you first approached me.",
	"4" : "I’m content with my life, but i just miss how things used to be.",
	"5" : "When I was in my primary and secondary classes, I was shy.",
	"6" : "Why do people think that if you cry you’re weak? It’s okay to cry, it’s okay to show your emotions.",
	"7" : "I just really want them to like me.",
	"8" : "I love her and she does not know that.",
	"9" : "I don’t even have the motivation to attend school right now. They should accept that online classes don’t work.",
	"10" : "How do I tell her I'm actually a girl?",
	"11" : "I have no reason to be sad. No reason at all.",
	"12" : "Sadness is confusing.",
	"13" : "I have good friends.",
	"14" : "I never wanted kids. I felt that way for as long as I can remember.",
	"15" : "I miss you so much and think about you every single day.",
	"16" : "I wish I could just go to bed.",
	"17" : "Everyone knows that someone, somewhere else in the world, is better than them at something.",
	"18" : "I’m tired of people who say “it gets better”.",
	"19" : "I want my life to have meaning.",
	"20" : "It does get better.",
	"21" : "I’m one of them.",
	"22" : "VR helped me battle social anxiety.",
	"23" : "We need people to participate in an electric zone policy.",
	"24" : "I haven’t always been kind.",
	"25" : "I’ve been a bad person.",
	"26" : "I’m so mad that there are so many bad guys in the world.",
	"27" : "I kinda see why people like Aladdin.",
	"28" : "I fully support every sexuality and gender.",
	"29" : "A beautiful heart finds beauty in everything.",
	"30" : "I feel so drained from everything.",
	"31" : "I’m sorry.",
	"32" : "I wanted to be true with my feelings.",
	"33" : "It’s going to be a long night.",
	"34" : "I’m tired of being miserable five days a week.",
	"35" : "I don’t buy the whole “well, that’s life”.",
	"36" : "Why do humans suck?",
	"37" : "I’ve made it into graduate school!",
	"38" : "I don’t want to go to work.",
	"39" : "Feeling very judged.",
	"40" : "I’m tired.",
	"41" : "I’m sorry, me from the past.",
	"42" : "I am finally healing.",
	"43" : "You did your best and it’s okay.",
	"44" : "I really need help.",
	"45" : "I wish I had what others have.",
	"46" : "It is my birthday.",
	"47" : "I hate my dad.",
	"48" : "I regret every decision I made in my life.",
	"49" : "Mom took very good care of me.",
	"50" : "I have never written out my feelings.",
	"51" : "Do you think that there will be television in heaven?",
	"52" : "Heaven is full of all that is good. The best shows are in heaven.",
	"53" : "l love korina. I love korina. I love korina. I love korina. I love korina. I love korina. I love korina. I love korina. I love korina.",
	"54" : "I’m 9 months sober today.",
	"55" : "I, somehow, made it to 21.",
	"56" : "The American Healthcare system is broken.",
	"57" : "It makes me sad that kids don’t play outside anymore.",
	"58" : "Love is not all you need.",
	"59" : "I’m in love with my girlfriend.",
	"60" : "Mom is sending my brother to boarding school.",
	"61" : "I’m not a person.",
	"62" : "I wanted to feel special.",
	"63" : "Confessed and got what I expected.",
	"64" : "I feel like a robot.",
	"65" : "I have never felt attractive.",
	"66" : "I hate this.",
	"67" : "I’m a clown.",
	"68" : "I wish my family would understand and respect me.",
	"69" : "Philosophy gave me a new outlook on life.",
	"70" : "Your footprints are still on my heart.",
	"71" : "STOP CALLING ME.",
	"72" : "I hate when I wake up later than 12pm.",
	"73" : "Oh no.",
	"74" : "I’m kinda convinced February 27th is a cursed day.",
	"75" : "The fact that everyone eventually dies is somehow consoling.",
	"76" : "I just want a hug…",
	"77" : "I love rain, because then I see that even gods cry sometimes",
	"78" : "I’m almost 18. Ugly as hell, gotta admit it.",
	"79" : "I think you should be who you want to be.",
	"80" : "do you see me? i can feel your eyes",
	"81" : "as a warning, you don’t belong here",
	"82" : "beware of",
	"83" : "quiet now child",
	"84" : "THERE’S NOTHING LEFT FOR YOU HERE",
	"85" : "?",
	"86" : "stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! stupid idiot! ",
	"87" : "i want to be real",
	"88" : "How did you get this far? You should really go back now.",
	"89" : "Are you sure about this      I see the man from my eyes",
	"90" : "We knew you weren’t safe by yourself. But now you’re safe. :)",
	"91" : "I see him. He is watching me.",
	"92" : "We’ll Decide Your Fate",
	"93" : "can you feel your legs?",
	"94" : "behind",
	"95" : "Did you bring it back?",
	"96" : "DON’T   LOOK   AT  ME",
	"97" : "Do you belong here? When are you leaving?",
	"98" : "It’s too cold out there, come inside",
	"99" : "It’s not here, go back",
	"100" : "Me and                used to play all the time",
	"101" : "false reality false reality false reality false reality false reality ",
	"102" : "This is A Dream",
	"103" : "It’s late now, darling. Didn’t you look at the window?",
	"104" : "everythingisgoingdownhill",
	"105" : "thanks god you’re a capsule"
}

func _ready () -> void:
	_hide()	
	dialogue_finished = true


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if dialogue_finished:
			_hide()
		else:
			show_tween.stop_all()
			text.percent_visible = 1
			_show()
			dialogue_finished = true

func show_dialogue (id : int) -> void:
	rng.randomize()
	
	var dialogue = load_dialogue()
	
	dialogue_finished = false
	var txt = dialogue[str(id)]
	text.bbcode_text = "[center]" + txt
	#Global.dialogues[id] = txt
	
	text.percent_visible = 0
	
	show_tween.interpolate_property(
		text, 
		"percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	show_tween.start()
	
	
	_show()
	pass
	
func load_dialogue () -> Dictionary:
	#var file = File.new()
	#assert (file.file_exists (dialogue_file_path))

	#file.open (dialogue_file_path, File.READ)
	#var dialogue = parse_json(file.get_as_text()) as Dictionary
	#assert (dialogue.size() > 0)

	return dial


func _hide () -> void:
	ui_elements.hide()
	audio.stop()


func _show () -> void:
	ui_elements.show()
	audio.play()
	


func _on_ShowDialogueTween_tween_all_completed() -> void:
	dialogue_finished = true
