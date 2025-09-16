class_name GameConstants

# Time
const HOURS_PER_DAY = 3  # Morning, Afternoon, Evening
const SECONDS_PER_HOUR = 1.0  # For testing, increase later

# Creature
const MAX_CREATURE_AGE = 20
const EVOLUTION_STAGES = ["blob", "baby", "child", "teen", "adult", "senior"]

# Economy
const STARTING_MONEY = 500
const DAILY_UPKEEP_BASE = 10
const PASTURE_UPKEEP = 2

# Facility
const STARTING_ACTIVE_SLOTS = 3
const STARTING_PASTURE_SLOTS = 5
const MAX_ACTIVE_SLOTS = 10
const MAX_PASTURE_SLOTS = 20

# Food Costs
const FOOD_COSTS = {
    "basic": 5,
    "quality": 15,
    "premium": 25
}

# Training Costs
const TRAINING_COSTS = {
    "free": 0,
    "basic": 25,
    "professional": 50,
    "master": 100
}