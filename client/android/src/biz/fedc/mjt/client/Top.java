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

	private static final int REQUEST_CAMERA_BRIDGE = 1;

	private static final String TOP_HTML="file:///android_asset/www/index.html";	
	
	private WebView webview = null;

	String htmlGetParams = null;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.webview = new WebView(this);
		WebSettings settings = webview.getSettings();
		settings.setJavaScriptEnabled(true);
		//settings.setJavaScriptCanOpenWindowsAutomatically(true);
		//settings.setLayoutAlgorithm(LayoutAlgorithm.NORMAL);
		webview.addJavascriptInterface(new CameraBridge(), "androidcamera");
		webview.addJavascriptInterface(new LogBridge(), "androidlog");
		
		webview.loadUrl(TOP_HTML);		
		setContentView(webview);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
		if(requestCode == REQUEST_CAMERA_BRIDGE){
			Log.d(TAG,"intent from CameraBridge recived");
			if(resultCode == RESULT_OK){
				Bundle extras=intent.getExtras();
				if(extras != null){
					String imgurl = extras.getString("imgurl");
					if(imgurl == null || imgurl == ""){
						Log.e(TAG,"intent extra string from cameraBridge is null or empty" );
					}else{
						String url=TOP_HTML + "?"+ htmlGetParams + "&img_url="  +  URLEncoder.encode(imgurl);
						Log.d(TAG,"webview.loadUrl " + url);
						webview.loadUrl(url);			
					}
				}else{
					Log.e(TAG,"intent extra from CameraBridge is null");
				}
			}else{
				Log.e(TAG,"intent from CameraBridge return code is bad " + resultCode );				
			}
		}
	}
	
	


	public class CameraBridge {
		public void capture(String getParams) {
			
			Log.d(TAG, "CameraBridge: capture. htmlGetParam=" + getParams);
			
			htmlGetParams  = getParams;
			Intent intent = new Intent(getApplicationContext(),Photo.class);
			intent.putExtra("getParam", getParams);
			startActivityForResult(intent, REQUEST_CAMERA_BRIDGE);	
		}
		
		public void select(String getParam) {
			Log.d(TAG, "CameraBridge: select. getParam=" + getParam);
			webview.loadUrl("file:///android_asset/www/index.html?bakaze=nan&jikaze=nan&honba_num=0&is_tsumo=true&dora_num=0&reach_num=0&is_ippatsu=false&is_haitei=false&is_rinshan=false&is_chankan=false&is_tenho=false&is_chiho=false&&img_url=%2Fassets%2Fimage%2F114_normal.jpeg%3F1309715933");	

		}
	}

	public class LogBridge {
		public void d(String str) {
			Log.d(TAG, str);
		}
		public void e(String str) {
			Log.e(TAG, str);
		}
	}

}
