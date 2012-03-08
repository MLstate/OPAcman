##register is_present : -> bool
##args()
{
    var present = MindWave.displayIcon();
    if (present) MindWave.setSignalValue(250);
    return present;
}

##register get_attention_level : -> int
##args()
{
    return MindWave.getAttentionLevel();
}

##register get_meditation_level : -> int
##args()
{
    return MindWave.getMeditationLevel();
}

##register get_blink_strength : -> int
##args()
{
    var bs = MindWave.getBlinkStrength();
    MindWave.setBlinkStrength(-1);
    return bs;
}
