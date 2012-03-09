import mindwave

get_nb_moves() =
  att = MindWave.get_attention_level()
  med = MindWave.get_meditation_level()
  if not(MindWave.is_present()) then 1
  else
    slow = if att < 40 && Random.int(101) < 20 then (-2) else 0
    if med > 70 && Random.int(101) < 20 then slow+3
    else slow+2

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
