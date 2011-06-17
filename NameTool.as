package  org.nodihsop.bbgame.util
{
	public class NameTool
	{
		private static var counter:uint = 0;
		private static var lastString:String = "fromNameTool";
		public static function getUniqueName():String
		{
				return (++counter) + lastString;
		}
	}
}