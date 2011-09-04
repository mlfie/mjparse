package biz.fedc.mjt.client;

import java.net.URLEncoder;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class Top extends Activity {

	private static final String TAG = "mjt-client";

	private static final int REQUEST_TO_PHOTO = 1;

	private static final String TOP_HTML="file:///android_asset/www/index.html";	
	
	private WebView webview = null;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.webview = new WebView(this);
		WebSettings settings = webview.getSettings();
		settings.setJavaScriptEnabled(true);
		//settings.setJavaScriptCanOpenWindowsAutomatically(true);
		//settings.setLayoutAlgorithm(LayoutAlgorithm.NORMAL);
		webview.addJavascriptInterface(this, "android");
		
		webview.loadUrl(TOP_HTML);		
		setContentView(webview);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
		if(requestCode == REQUEST_TO_PHOTO){
			Log.d(TAG,"intent from CameraBridge recived");
			if(resultCode == RESULT_OK){
				Bundle extras=intent.getExtras();
				if(extras != null){
					String imgurl = extras.getString("imgurl");
					if(imgurl == null || imgurl == ""){
						Log.e(TAG,"intent extra string from cameraBridge is null or empty" );
					}else{
						Log.d(TAG,"imgurl " + imgurl);
						webview.loadUrl("javascript:setImgUrl('" + imgurl + "')");			
					}
				}else{
					Log.e(TAG,"intent extra from CameraBridge is null");
				}
			}else{
				Log.e(TAG,"intent from CameraBridge return code is bad " + resultCode );				
			}
		}
	}
	
	
	public void capturePhoto() {
		Log.d(TAG, "capturePhoto");
		Intent intent = new Intent(getApplicationContext(),Photo.class);
		intent.putExtra(Photo.INTENT_KEY, Photo.INTENT_VAL_CAPTURE);
		startActivityForResult(intent, REQUEST_TO_PHOTO);	
	}
	
	public void selectPhoto() {
		Log.d(TAG, "selectPhoto");
		Intent intent = new Intent(getApplicationContext(),Photo.class);
		intent.putExtra(Photo.INTENT_KEY, Photo.INTENT_VAL_SELECT);
		startActivityForResult(intent, REQUEST_TO_PHOTO);	

	}


}
