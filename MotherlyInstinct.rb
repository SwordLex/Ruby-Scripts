Battle::AbilityEffects::OnSwitchIn.add(:MOTHERLYINSTINCT,
  proc { |ability, battler, battle, switch_in|
    
    has_child = battle.pbParty(battler.index).any? { |pkmn| 
      pkmn.egg? && pkmn.able? && [:CUBONE, :MAROWAK].include?(pkmn.species)   
    }

    if has_child && battler.pbCanRaiseStatStage?(:DEFENSE, battler)
      battle.showAbilitySplash(battler)
      battler.pbRaiseStatStagebyAbility(:DEFENSE, 1, battler)
      battle.pbHideAbilitySplash(battler)
    end
  }
)