class_name ActivityType

enum Activity {
    REST,
    CARE_BASIC,
    CARE_QUALITY,
    CARE_PREMIUM,
    TRAIN_BASIC,
    TRAIN_QUALITY,
    TRAIN_PREMIUM,
    WORK
}

static func get_display_name(activity: Activity) -> String:
    match activity:
        Activity.REST: return "Rest Day"
        Activity.CARE_BASIC: return "Basic Care"
        Activity.CARE_QUALITY: return "Quality Care"
        Activity.CARE_PREMIUM: return "Premium Care"
        Activity.TRAIN_BASIC: return "Basic Training"
        Activity.TRAIN_QUALITY: return "Quality Training"
        Activity.TRAIN_PREMIUM: return "Premium Training"
        Activity.WORK: return "Send to Work"
    return ""

static func get_description(activity: Activity) -> String:
    match activity:
        Activity.REST: return "Let them rest. Restores energy, no aging."
        Activity.CARE_BASIC: return "Basic food and care. Maintains stats."
        Activity.CARE_QUALITY: return "Good food and attention. Improves mood."
        Activity.CARE_PREMIUM: return "Luxury treatment. Maximum happiness."
        Activity.TRAIN_BASIC: return "Basic training with adequate food."
        Activity.TRAIN_QUALITY: return "Professional training with good meals."
        Activity.TRAIN_PREMIUM: return "Expert training with gourmet food."
        Activity.WORK: return "Send to work. Earns money but tiring."
    return ""

static func get_key(activity: Activity) -> String:
    match activity:
        Activity.REST: return "rest"
        Activity.CARE_BASIC: return "care_basic"
        Activity.CARE_QUALITY: return "care_quality"
        Activity.CARE_PREMIUM: return "care_premium"
        Activity.TRAIN_BASIC: return "train_basic"
        Activity.TRAIN_QUALITY: return "train_quality"
        Activity.TRAIN_PREMIUM: return "train_premium"
        Activity.WORK: return "work"
    return ""

static func ages_creature(activity: Activity) -> bool:
    return activity != Activity.REST