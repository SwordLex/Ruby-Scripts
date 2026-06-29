MidbattleHandlers.add(:midbattle_scripts, :LUCAS_MIDBATTLE,
  proc { |battle, idxBattler, idxTarget, trigger|

    #1. Get the data from the trainer who triggered the trigger (if applies)
    battler = battle.battlers[idxBattler] if idxBattler

    case trigger
    when "BattlerFainted"

      trainer = battle.pbGetOwnerFromBattlerIndex(idxBattler)
		  next if !trainer

      next if battler.pbOwnedByPlayer? # Only trigger if the ally is an NPC
      next if battler.species != :ZUBAT


      battle.pbDisplayPaused(_INTL("Your ally has no more Pokémon to fight with!"))
      battle.decision = 3
      pbSEPlay("Battle flee")
      battle.scene.pbDisplay(_INTL("{1} has fled from battle!", trainer.name))
    end
  }
)