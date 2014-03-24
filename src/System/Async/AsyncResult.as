package System.Async 
{
	import System.Async.IAsyncResult;
	import System.Delegate;
	import System.IDelegate;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AsyncResult implements IAsyncResult 
	{
		private var mAsyncState:Object;
		private var mIsCompleted:Boolean;;
		private var mOnError:Delegate;
		private var mOnComplete:Delegate;
		
		public function AsyncResult(asyncState:Object) 
		{
			mAsyncState = asyncState;
			mIsCompleted = true;
			mOnError = new Delegate();
			mOnComplete = new Delegate();
		}
		
		public function get AsyncState():Object 
		{
			return mAsyncState;
		}
		
		public function get IsCompleted():Boolean 
		{
			return mIsCompleted;
		}
		
		public function get OnError():IDelegate 
		{
			return mOnError;
		}
		
		public function get OnComplete():IDelegate 
		{
			return mOnComplete;
		}
		
		public function Dispose():void 
		{
			mAsyncState = null;
			if (mOnError)
			{
				mOnError.Dispose();
				mOnError = null;
			}
			if (mOnComplete)
			{
				mOnComplete.Dispose();
				mOnComplete = null;
			}
			mIsCompleted = false;
		}
		
	}

}