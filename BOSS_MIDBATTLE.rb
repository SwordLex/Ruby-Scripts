$boss_first_faint_tracker = {} if !defined?($boss_first_faint_tracker)

MidbattleHandlers.add(:midbattle_scripts, :BOSS_MIDBATTLE,
	proc { |battle, idxBattler, idxTarget, trigger|
		#1. Identify the foe
		trainer = battle.pbGetOwnerFromBattlerIndex(1)
		next if !trainer
		
		#Trainer's name upcased for avoiding format errors
		boss_id = trainer.name.upcase
		
		#2. Get the data from the trainer who triggered the trigger (if applies)
		battler = battle.battlers[idxBattler] if idxBattler

		# Initialize the rastreator if doesn't exist yet
		$boss_first_faint_tracker[boss_id] = false if !$boss_first_faint_tracker[boss_id]

		# ==========================================================================
		# SPECIAL CASE: LANCE'S GYARADOS (Trigger: After being sent out)
		# ==========================================================================
		if trigger == "AfterSendOut_foe" && boss_id == "LANCE"
			if battler && battler.species == :GYARADOS
				msg = "Did you think I only ruled over the land? EVEN THE SEA OBEYS MY ORDERS!"
				battle.scene.pbStartSpeech(1)
				battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg
				next
			end
		end
		
		# ==========================================================================
		# GENERIC LOGIC
		# ==========================================================================
		case trigger
		
		# ----------- RULE 1: WHEN FOE'S FIRST POKEMON FAINTS -----------
		when "BattlerFainted_foe"
			#Execute only if the boss's first Pokemon has fainted
			unless $boss_first_faint_tracker[boss_id]
				first_faint_speech = {
					"CAMELLIA" 				 	=> "You’ve got a rather unusual Pokémon; I must admit you’ve impressed me… just a little.",
					"LADY SELPHY"            	=> "INSOLENT! HOW DARE YOU TOUCH MY BELOVED POKÉMON WITH YOUR FILTHY POKÉMON?!",
					"FOSSILMANIAC_MTMOON"     	=> "What’s going on? I hadn’t reckoned on you being that strong.",
					"BILL"                    	=> "How can a simple Rocket possess a Pokémon with that much power?!",
					"FOSSILMANIAC_ROCKTUNNEL" 	=> "Just as strong as last time, yet you will never again be an unpredictable factor.",
					"DAISY"                   	=> "You may know how to train, but you and your lot will always remain the scum of society.",
					"BILL_SILPH"              	=> "Just as I expected... You’ll never be able to surprise me again.",
					"ERIKA"                   	=> "Even the most beautiful flowers have their time... But I never expected you to be the one to bring about their demise.",
					"BROCK"                   	=> "As a Pokémon breeder, it pains me to have allowed my partner to suffer such injuries.",
					"MISTY"                   	=> "I admit I wasn’t prepared for a tsunami like that.",
					"SURGE"              	  	=> "A fallen soldier fuels the fury of the rest of the squad; the war has only just begun.",
					"SABRINA"                 	=> "... \nNot even with my psychic powers could I have foreseen your strength... \nPerhaps I need to take this more seriously than I’d like to...",
					"JANINE"                  	=> "Your technique... reminds me of Dad... all the more reason to beat you.",
					"BLAINE"                  	=> "A specimen worthy of study.",
					"PROTON"				  	=> "That’s how you should battle. ",
					"PETREL"				  	=> "Heh heh, you’re the bomb, mate",
					"ARIANA"                  	=> "Oh, really? How interesting.",
					"ARCHER"                  	=> "You wouldn’t be here with us if you weren’t capable of surpassing us.",
					"WILL"                    	=> "Allegro, adagio. I can’t pigeonhole you into a single rhythm; you ebb and flow like a wild melody.",
					"KOGA"                    	=> "Before you can be a dragon, you have to suffer like an ant",
					"BRUNO"                   	=> "A single crack isn’t enough to bring me down.",
					"KAREN"                   	=> "Well, well, you’re quite the handful, despite that angelic face of yours.",
					"LANCE"                   	=> "What do you think you’re doing to a king’s beasts?"
				}
				msg = first_faint_speech[boss_id]
				battle.scene.pbStartSpeech(1)
				battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg
				$boss_first_faint_tracker[boss_id] = true
			end
			
		# ----------- RULE 2: BEFORE MEGA EVOLUTION -----------
		when "BeforeMegaEvolution_foe"
			mega_speech = {
				"ERIKA" 	=> "Just look at the fruits of my labour in my garden! Mega Evolution!",
				"BROCK" 	=> "Steelix, when faced with adversity, we become even tougher! Mega Evolution!",
				"MISTY" 	=> "I’m going to show you why Starmie is my star! Mega Evolution!",
				"SURGE" 	=> "Raichu, as the squad leader that you are, scorch every enemy that dares to stand in our way! Mega Evolution!",
				"SABRINA" 	=> "I never thought this moment would come... Alakazam, sort this out for me! Mega Evolution!",
				"JANINE" 	=> "Beedrill! Let’s boost your venom and show them what we’re made of! Mega Evolution!",
				"BLAINE" 	=> "Behold the fire of that Pokémon that was always meant to be a dragon! Charizard Mega Evolution!",
				"PROTON" 	=> "You’ve got some fire, little one, but ours is stronger! Camerupt Mega Evolution!",
				"PETREL" 	=> "Take flight, Pinsir, and strike twice as hard and twice as fast! Mega Evolution!",
				"ARIANA" 	=> "A new form with the future in mind! Victribeel Mega evolve! Bring equal measures of despair and life!",
				"ARCHER" 	=> "You’re my soulmate, Houndoom - let’s show this kid that being a Rocket Commander is no easy task! Mega Evolution!",
				"WILL" 		=> "I wonder how you’ll get to grips with this tune... Mega Evolution!",
				"KOGA" 		=> "Glory does not lie in never falling, but in getting back up every time you fall. Mega Evolution!",
				"BRUNO" 	=> "AAAAAAH! Let’s go, Blaziken Mega Evolution!",
				"KAREN" 	=> "Now the real battle begins, little one. Mega Evolution!",
				"LANCE" 	=> "Salamence! Soar through the skies and let a deluge rain down upon these fools! Mega Evolution!"
			}
			msg = mega_speech[boss_id]
			battle.scene.pbStartSpeech(1)
			battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg

		# ----------- RULE 3: LAST BOSS' POKEMON -----------
		when "AfterLastSendOut_foe"
			last_foe_speech = {
				"CAMELLIA" 				 	=> "Right then… time to get serious",
				"LADY SELPHY"            	=> "Unbelievable... To be pushed to this point by a Rocket... HOW MUCH FURTHER ARE YOU GOING TO TARNISH MY HONOUR?",
				"FOSSILMANIAC_MTMOON"     	=> "You are an unknown quantity that I must eliminate.",
				"BILL"                   	=> "NO! I can’t lose to a Rocket!",
				"FOSSILMANIAC_ROCKTUNNEL"	=> "Right, here we go again",
				"DAISY"                   	=> "It’s obvious you’re no ordinary Rocket. But I haven’t lost yet.",
				"BILL_SILPH"              	=> "Just as I expected... You’ll never be able to surprise me again.",
				"ERIKA" 					=> "I can’t believe how much I’m enjoying our battle… I don’t want it to end just yet.",
				"BROCK" 					=> "It’s been a while since I’ve found myself in this situation… you’re amazing!",
				"MISTY" 					=> "I’ve been knocked down by many waves, but I’ve never, ever had to face one like you.",
				"SURGE" 					=> "Here comes my commander. Get ready for some foolproof tactics!",
				"SABRINA" 					=> "My last Pokémon... To think your power is on a par with mine... I must admit, I’m impressed.",
				"JANINE" 					=> "Don’t count your chickens just yet. My last Pokémon is invincible.",
				"BLAINE" 					=> "I’m getting fed up with your arrogance. I am the Master of Fire; you won’t put me out that easily.",
				"PROTON" 					=> "A major problem, no doubt. But it is not insurmountable.",
				"PETREL" 					=> "Holy shit! You’re on top form, ain’t'ya? But anyway, brace yourself because there are some bumps in the road ahead.",
				"ARIANA" 					=> "Let this be a lesson: underestimating you is not a good idea.",
				"ARCHER" 					=> "Hmm... I didn’t expect this to go in this direction.",
				"WILL" 						=> "And here comes the climax, ladies and gentlemen!",
				"KOGA" 						=> "Enough with the proverbs. I can’t let you trample on my honour as a ninja by thwarting my carefully crafted strategy.",
				"BRUNO" 					=> "You... you haven't beaten me yet, brat!",
				"KAREN" 					=> "You certainly haven’t come here to play around. Right, it’s time to get serious.",
				"LANCE" 					=> "NO! My Pokémon! Well, don’t panic – you’ve reached the throne, BUT YOU HAVEN’T SAT ON IT YET!"
			}
			msg = last_foe_speech[boss_id]
			battle.scene.pbStartSpeech(1)
			battle.pbDisplayPaused(_INTL(msg, battler.name)) if msg
		end
	}
)