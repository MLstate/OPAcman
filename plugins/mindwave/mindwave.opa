package mindwave

/**
 * Plugin for MindWave (NeuroSky - http://www.neurosky.com/)
 */
module MindWave {

  client function is_present() {
    (%%mindwave.is_present%%)()
  }

  client function get_attention_level() {
    (%%mindwave.get_attention_level%%)()
  }

  client function get_meditation_level() {
    (%%mindwave.get_meditation_level%%)()
  }

  client function get_blink_strength() {
    (%%mindwave.get_blink_strength%%)()
  }

}
