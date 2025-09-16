class_name GameConstants

# Time
const DAYS_PER_CREATURE = 20  # Maximum lifespan

# Creature
const EVOLUTION_STAGES = ["blob", "baby", "child", "teen", "adult", "senior"]
const EVOLUTION_DAYS = {
    "blob": 0,      # Days 0-2
    "baby": 3,      # Days 3-5
    "child": 6,     # Days 6-8
    "teen": 9,      # Days 9-12
    "adult": 13,    # Days 13-18
    "senior": 19    # Days 19+
}

# Economy
const STARTING_MONEY = 500
const DAILY_UPKEEP_ACTIVE = 10  # Cost per day for active creature
const DAILY_UPKEEP_PASTURE = 2  # Cost per day for pastured creature

# Facility
const STARTING_ACTIVE_SLOTS = 3
const STARTING_PASTURE_SLOTS = 5

# Activity Costs (food is included in the activity!)
const ACTIVITY_COSTS = {
    "rest": 0,           # No cost, but no progress
    "care_basic": 10,    # Basic food + care
    "care_quality": 25,  # Good food + attention  
    "care_premium": 50,  # Best food + pampering
    "train_basic": 20,   # Food + basic training
    "train_quality": 40, # Food + good training
    "train_premium": 75, # Food + expert training
    "work": 0            # They eat at work
}

# Activity Effects on Stats
const ACTIVITY_EFFECTS = {
    "rest": {"hunger": 0, "happiness": 10, "energy": 50, "training": 0},
    "care_basic": {"hunger": 50, "happiness": 20, "energy": 20, "training": 0},
    "care_quality": {"hunger": 80, "happiness": 50, "energy": 30, "training": 0},
    "care_premium": {"hunger": 100, "happiness": 80, "energy": 50, "training": 0},
    "train_basic": {"hunger": 40, "happiness": -10, "energy": -20, "training": 20},
    "train_quality": {"hunger": 60, "happiness": 0, "energy": -20, "training": 40},
    "train_premium": {"hunger": 80, "happiness": 20, "energy": -10, "training": 60},
    "work": {"hunger": 30, "happiness": -20, "energy": -40, "training": 5}
}