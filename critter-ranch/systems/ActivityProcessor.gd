extends Node
class_name ActivityProcessor

static func can_afford_activity(activity: ActivityType.Activity) -> bool:
    var key = ActivityType.get_key(activity)
    var cost = GameConstants.ACTIVITY_COSTS.get(key, 0)
    return EconomyManager.can_afford(cost)

static func process_activity(creature_data: Dictionary, activity: ActivityType.Activity) -> Dictionary:
    var key = ActivityType.get_key(activity)
    var cost = GameConstants.ACTIVITY_COSTS.get(key, 0)
    var effects = GameConstants.ACTIVITY_EFFECTS.get(key, {})
    
    # Spend money
    if cost > 0 and not EconomyManager.spend(cost, ActivityType.get_display_name(activity)):
        push_error("Could not afford activity!")
        return creature_data
    
    # Apply effects to creature stats
    var result = creature_data.duplicate(true)
    
    # Apply stat changes
    for stat_name in effects:
        if stat_name in result.stats:
            var old_value = result.stats[stat_name]
            var change = effects[stat_name]
            var new_value = clamp(old_value + change, 0, 100)
            result.stats[stat_name] = new_value
            
            # Emit signal for UI updates
            SignalBus.creature_stat_changed.emit(result.id, stat_name, new_value)
    
    # Age creature if activity causes aging
    if ActivityType.ages_creature(activity):
        result.age_days += 1
        SignalBus.creature_aged.emit(result.id, result.age_days)
    
    # Track economics
    result.lifetime_costs += cost
    
    # Log activity
    print("Processed %s for creature %s" % [ActivityType.get_display_name(activity), result.name])
    
    return result