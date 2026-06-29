Battle::AbilityEffects::OnDealingHit.add(:LULLABY,
  proc { |ability, user, target, move, battle, hitByMove, checkCategory|
    next if target.fainted? || !hitByMove
    next if !target.pbCanSleep?(user, false)

    evos  = GameData::Species.get(target.species).get_evolutions
    phase = GameData::Species.get(target.species).stage

    if evos.length > 0 && phase == 0
      battle.pbShowAbilitySplashes(user)
      target.pbSleep
      battle.pbHideAbilitySplashes(user)
    end
  }
)