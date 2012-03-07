import mindwave

@client attention : reference(int) = ClientReference.create(100)

get_attention() = ClientReference.get(attention)

@client init_scheduling =
  Scheduler.timer(1000, ->
    if MindWave.is_present() then (
      att = MindWave.get_attention_level()
      do ClientReference.set(attention, att)
      Log.info("Attention", "{att}")
    ) else (
      Log.info("Mindwave", "NONE")
    )
  )

mindwave_flash =
  <div id="flashContent">
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="220" height="400" id="FlashToJs" align="middle">
      <param name="movie" value="/resources/neurosky/FlashToJs/FlashToJs.swf" />
      <param name="quality" value="high" />
      <param name="bgcolor" value="#ffffff" />
      <param name="play" value="true" />
      <param name="loop" value="true" />
      <param name="wmode" value="window" />
      <param name="scale" value="showall" />
      <param name="menu" value="true" />
      <param name="devicefont" value="false" />
      <param name="salign" value="" />
      <param name="allowScriptAccess" value="sameDomain" />
      {Xhtml.of_string_unsafe("<!--[if !IE]>-->")}
      <object type="application/x-shockwave-flash" data="/resources/neurosky/FlashToJs/FlashToJs.swf" width="220" height="400">
        <param name="movie" value="/resources/neurosky/FlashToJs/FlashToJs.swf" />
        <param name="quality" value="high" />
        <param name="bgcolor" value="#ffffff" />
        <param name="play" value="true" />
        <param name="loop" value="true" />
        <param name="wmode" value="window" />
        <param name="scale" value="showall" />
        <param name="menu" value="true" />
        <param name="devicefont" value="false" />
        <param name="salign" value="" />
        <param name="allowScriptAccess" value="sameDomain" />
      {Xhtml.of_string_unsafe("<!--<![endif]-->")}
        <a href="http://www.adobe.com/go/getflash">
                <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
        </a>
      {Xhtml.of_string_unsafe("<!--[if !IE]>-->")}
      </object>
      {Xhtml.of_string_unsafe("<!--<![endif]-->")}
    </object>
  </div>
