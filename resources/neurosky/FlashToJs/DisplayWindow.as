package
{
	import flash.display.*;
	import flash.events.*;//for event handling
	import flash.net.Socket;//Sockets
	import flash.utils.*;
	import flash.external.ExternalInterface;
	import flash.system.*;
	import com.adobe.serialization.json.*;//as3corelib JSON support
	public class DisplayWindow extends Sprite
	{
		// Public Properties:
		public var attention:uint;
		public var meditation:uint;
		public var poorSignal:uint;


		public var myTimer:Timer;
		public var jsTimer:Timer;
		public var timeCount:uint;
		public var hasStarted:Boolean;

		// Private Properties:
		private var thinkGearSocket:Socket;
		public function DisplayWindow()
		{
			Security.allowDomain("*");

			var self = this;

			hasStarted = false;
			//To run the ThinkGear software without waiting for the JS, uncomment the line below
			//startThinkGearSocket();

			//Before the application tries to connect to the ThinkGearSocket, make sure JS is available
			waitForJs();
		}

		private function startThinkGearSocket()
		{
			if (! hasStarted)
			{
				hasStarted = true;
				log("Preparing ThinkGear...");
				thinkGearSocket = new Socket();
				thinkGearSocket.addEventListener(ProgressEvent.SOCKET_DATA,dataHandler);
				thinkGearSocket.addEventListener(ProgressEvent.PROGRESS,progressHandler);
				thinkGearSocket.connect("127.0.0.1",13854);
				if (thinkGearSocket.connected)
				{
					log("ThinkGear connected. Configuring...");
				}
				else
				{
					log("ThinkGear not connected. Configuring anyway...");
				}
				var configuration:Object = new Object();
				configuration["enableRawOutput"] = false;
				configuration["format"] = "Json";
				thinkGearSocket.writeUTFBytes(JSON.encode(configuration));
			}
			else
			{
				log("thinkGearSocket has already started");
			}
		}

		// Protected Methods:;
		private function progressHandler(e:ProgressEvent)
		{
			if (thinkGearSocket.connected)
			{
				log("ThinkGear connected. ProgressEvent occurred.");
			}
			else
			{
				log("ThinkGear not connected. ProgressEvent occurred.");
			}
		}
		private function dataHandler(e:ProgressEvent)
		{
			if (thinkGearSocket.connected)
			{
				log("ThinkGear connected. Receiving data.");
			}
			else
			{
				log("ThinkGear not connected. Receiving data.");
			}
			var packetString:String = thinkGearSocket.readUTFBytes(thinkGearSocket.bytesAvailable);
			if ((packetString == null))
			{
				log("packetString is NULL");
			}
			thinkGearSocket.flush();
			log("ThinkGearSocket flushed");

			var packets:Array = packetString.split(/\r/);
			log(("Packets length: " + packets.length));
			var data:Object;//temporary data
			for each (var packet:String in packets)
			{//iterate through each element
				if ((packet != ""))
				{//sometimes the line is blank so skip the line
					try
					{
						log("Packet: "+packet);
						data = JSON.decode(packet);
						//decode the data to an array
						if (data["poorSignalLevel"] != null)
						{//checking to see if the ''poorSignalLevel' key exists
							poorSignal = data["poorSignalLevel"];
							if ((poorSignal == 0))
							{
								attention = data["eSense"]["attention"];//assigning data to variables
								meditation = data["eSense"]["meditation"];
								//log("Attention: " + attention);//output attention data to debug
							}
							else
							{
								if ((poorSignal == 200))
								{
									attention = 0;
									meditation = 0;
									if (!data["eSense"])
										poorSignal = 250;
								}
							}
						}
						label1.text = "Attention: " + attention.toString() + "\nMeditation: " + meditation.toString() + "\nPoor Signal: " + poorSignal.toString();
						sendDataToJavaScript(poorSignal,attention,meditation);
					}
					catch (jError:JSONParseError)
					{
						log("there was a JSONParseError: " + packet);
						// restart a connection at first error :(
						hasStarted = false;
						thinkGearSocket.close();
						startThinkGearSocket();
						sendDataToJavaScript(250, 0, 0);
						return;
					}

				} else log("empty packet");
				data = null;

			}/*for each*/
		}/*function dataHandler*/
		/**
		 * iconLevel is the poor signal value
		 * attentionLevel is the attention value
		 * meditationLevel is the meditation value
		 * There may be some need to check the types of these values, because they are not all
		 * being passed to the Javascript, from what I can tell
		 */
		public function sendDataToJavaScript(iconLevel:uint,attentionLevel:uint,meditationLevel:uint)
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call("MindWave.setSignalValue",iconLevel);
				ExternalInterface.call("MindWave.setAttentionLevel",attentionLevel);
				ExternalInterface.call("MindWave.setMeditationLevel",meditationLevel);
			}
			else
			{
				log("ExternalInterface is not available to send data to JS");
			}
		}
		public function checkJs(event:TimerEvent)
		{
			log("Checking javascript...");
			if (ExternalInterface.available)
			{
				var jsReady:Boolean = ExternalInterface.call("isReady");
				if (jsReady)
				{
					jsTimer.stop();
					startThinkGearSocket();
				}
				else
				{
					log("JS is not Ready");
				}
			} else {
				log("No JS interface...");
			}
		}
		public function checkJsStopped(event:TimerEvent)
		{
			log("Javascript connection was not established");
		}
		private function waitForJs()
		{
			jsTimer = new Timer(1000,100);
			jsTimer.addEventListener(TimerEvent.TIMER,checkJs);
			jsTimer.addEventListener(TimerEvent.TIMER_COMPLETE,checkJsStopped);
			jsTimer.start();
		}

		private function receivedFromJavaScript(value:String):void
		{
			log((("JavaScript says: " + value) + "\n"));
		}
		private function checkJavaScriptReady():Boolean
		{
			var isReady:Boolean = false;
			if (ExternalInterface.available)
			{
				isReady = ExternalInterface.call("isReady");
			}
			return isReady;
		}
		private function log(message:String)
		{
			trace(message);
			label2.text = message;
			if (ExternalInterface.available)
			{
				ExternalInterface.call("console.log",message);
			}
		}
	}
}