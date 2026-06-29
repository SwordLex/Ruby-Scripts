Battle::AbilityEffects::OnSwitchIn.add(:MINDSPIKE,
    proc { |ability, battler, battle, switch_in|
        battle.pbShowAbilitySplash(battler)
        battle.allOtherSideBattlers(battler.index).each do |b|
            next if !b.near?(battler)
            b.pbLowerStatStageByAbility(:SPECIAL_ATTACK, 1, battler)
        end
        battle.pbHideAbilitySplash(battler)
    }
)
        