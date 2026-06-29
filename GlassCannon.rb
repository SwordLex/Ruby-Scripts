Battle::AbilityEffects::OnSwitchIn.add(:GLASSCANNON,
	proc { |ability, battler, battle, switch_in|
		battle.showAbilitySplash(battler)
		battler.pbRaiseStatStagebyAbility(:SPECIAL_ATTACK, 2, battler)
		battler.pbRaiseStatStagebyAbility(:SPEED, 1, battler)
		battler.pbRaiseStatStagebyAbility(:ACCURACY, 1, battler)
		battler.pbLowerStatStagebyAbility(:DEFENSE, 2, battler)
		battler.pbLowerStatStagebyAbility(:SPECIAL_DEFENSE, 2, battler)
		battler.pbLowerStatStagebyAbility(:EVASION, 2, battler)
	}
)

Battle::AbilityEffects::OnEndOfUsingMove.add(:GLASSCANNON,
	proc { |ability, user, target, move, battle|
		next if user.effects[PBEffects::Choice] != nil
		next if move.id == nil
		user.effects[PBEffects::Choice] = move.id
	}
)