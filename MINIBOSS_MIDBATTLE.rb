$miniboss_first_faint_tracker = {} if !defined?($miniboss_first_faint_tracker)

MidbattleHandlers.add(:midbattle_scripts, :MINIBOSS_MIDBATTLE,
  proc { |battle, idxBattler, idxTarget, trigger|
    trainer = battle.pbGetOwnerFromBattlerIndex(1)
    next if !trainer

    miniboss_id = trainer.name.upcase

    battler = battle.battlers[idxBattler] if idxBattler

    # Initialize the rastreator if doesn't exist yet
		# Initialize the rastreator if doesn't exist yet
		$miniboss_first_faint_tracker[miniboss_id] = false if !$miniboss_first_faint_tracker[miniboss_id]

    case trigger
    
    when "BattlerFainted_foe"
      unless $miniboss_first_faint_tracker[miniboss_id]
        first_faint_foe = {
          "CAMELLIA" => "You never disappoint, huh?",
          "BLUE" => "(!) Excuse me? A Rocket defeated one of my Pokemon?",
          "RED" => "(...)(...)(...)",
          "ARIANA" => "You've got some nerve, kid. I like that.",
          "FUJI" => "I sense something different about you. Yet, a Rocket is a Rocket",
          "LEAF" => "... That was... AMAZING!",
          "GODOFGRUNTS" => "Pal, ya'ain't nothin' to play with, ain'tcha? I like that.",
          "LEAF'S MOM" => "Freaking awesome. Let's get carried away, sweetie."
        }
        msg = first_faint_foe[miniboss_id]
        battle.scene.pbStartSpeech(1)
        battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg
        $miniboss_first_faint_tracker[miniboss_id] = true
      end
    
    when "AfterLastSendOut_foe"
      last_pokemon_foe = {
        "CAMELLIA" => "YES! Battling you is the best teacher I could ever ask for!",
        "BLUE" => "(!) This is unacceptable! I won't let you win!",
        "RED" => "(...)(...)(...)",
        "ARIANA" => "Not bad, but I'm not done yet.",
        "FUJI" => "You're stronger than I expected. Impressive.",
        "LEAF" => "That was a close one! You're quite the trainer!",
        "GODOFGRUNTS" => "Alright, alright! You've got some skills!",
        "LEAF'S MOM" => "Damn, you're good! Let's see how you handle this!"
      }
      msg = last_pokemon_foe[miniboss_id]
      battle.scene.pbStartSpeech(1)
      battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg
    end
  }
)