extends Node

func _ready():
    print("=== Testing Activity System ===\n")
    
    # Create a test creature data
    var test_creature = {
        "id": "test_001",
        "name": "Fluffy",
        "age_days": 5,
        "stage": "baby",
        "stats": {
            "hunger": 30,
            "happiness": 60,
            "energy": 40,
            "training": 10
        },
        "lifetime_costs": 50
    }
    
    # Test 1: Display all activities
    print("Available Activities:")
    for activity in ActivityType.Activity.values():
        var display_name = ActivityType.get_display_name(activity)
        var key = ActivityType.get_key(activity)
        var cost = GameConstants.ACTIVITY_COSTS.get(key, 0)
        print("- %s: %dg" % [display_name, cost])
    
    print("\nStarting Money: %d" % EconomyManager.get_money())
    print("\nCreature Status Before:")
    print("- %s (Day %d)" % [test_creature.name, test_creature.age_days])
    print("- Hunger: %d, Happiness: %d, Energy: %d, Training: %d" % [
        test_creature.stats.hunger,
        test_creature.stats.happiness,
        test_creature.stats.energy,
        test_creature.stats.training
    ])
    
    # Test 2: Process an activity
    print("\n--- Processing Quality Training ---")
    var activity = ActivityType.Activity.TRAIN_QUALITY
    
    if ActivityProcessor.can_afford_activity(activity):
        test_creature = ActivityProcessor.process_activity(test_creature, activity)
        
        print("\nCreature Status After:")
        print("- %s (Day %d)" % [test_creature.name, test_creature.age_days])
        print("- Hunger: %d, Happiness: %d, Energy: %d, Training: %d" % [
            test_creature.stats.hunger,
            test_creature.stats.happiness,
            test_creature.stats.energy,
            test_creature.stats.training
        ])
        print("- Lifetime costs: %d" % test_creature.lifetime_costs)
        print("\nRemaining Money: %d" % EconomyManager.get_money())
    else:
        print("Cannot afford this activity!")
    
    # Test 3: Test REST (shouldn't age creature)
    print("\n--- Testing Rest Day ---")
    var initial_age = test_creature.age_days
    test_creature = ActivityProcessor.process_activity(test_creature, ActivityType.Activity.REST)
    print("Age before rest: %d, after: %d (should be same)" % [initial_age, test_creature.age_days])