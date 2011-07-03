package biz.fedc.mjt.client;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.DefaultHttpClient;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;

/**
 * Intent Camera Test
 */
public class Photo extends Activity {

	/** log tag */
	public static final String TAG = "mjt-client";
	/** ImageView */
	private static ImageView previewImage = null;

	private static final int REQUEST_PICK_CONTACT = 1;

	private static final String SERVER_URL = "http://fetaro-mjt.fedc.biz/images";
	private static final String PARAM_NAME = "image[image]";
	private static final String TMP_FILE_PATH = Environment
			.getExternalStorageDirectory()
			+ "/tmp.jpeg";

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.main);
		
		// preview ImageView
		previewImage = (ImageView) findViewById(R.id.previewImage);

		// Capture Button
		findViewById(R.id.captureButton).setOnClickListener(
				new OnClickListener() {
					public void onClick(View v) {
						Log.d(TAG, "captureButton:onClick() start");
						Intent i = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
						startActivityForResult(i, REQUEST_PICK_CONTACT);

					}
				});

		findViewById(R.id.SelectButton).setOnClickListener(
				new OnClickListener() {
					public void onClick(View v) {
						Intent intent = new Intent(Intent.ACTION_PICK);
						intent.setType("image/*");
						startActivityForResult(intent, REQUEST_PICK_CONTACT);

					}
				});

		findViewById(R.id.sendButton).setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Log.d(TAG, "sendButton:onClick() start");

				try {
					String imgurl = postFile(SERVER_URL, PARAM_NAME, TMP_FILE_PATH);
					//Activityの完了
					Intent intent = new Intent();
					intent.putExtra("imgurl", imgurl);
					setResult(Activity.RESULT_OK,intent);
					finish();
				} catch (Exception e) {
					Log.d(TAG, e.getMessage(), e);
				}
			}
		});
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
		super.onActivityResult(requestCode, resultCode, intent);
		Log.d(TAG, "onActivityResult:requestCode=" + requestCode
				+ ",resultCode=" + resultCode);

		if (resultCode == RESULT_OK) {

			Uri uri = intent.getData();
			Log.d(TAG, "onActivityResult:uri=" + uri.toString());

			previewImage.setImageURI(intent.getData());
			((Button) findViewById(R.id.sendButton)).setEnabled(true);

			try {
				InputStream in = getContentResolver().openInputStream(uri);
				createFile(in, TMP_FILE_PATH);
			} catch (Exception e) {
				Log.d(TAG, e.getMessage(), e);
			}
		}else{
			Log.d(TAG, "onActivityResult:camera fail!");
		}

	}

	private void createFile(InputStream inputStream, String filepath)
			throws IOException {
		Log.d(TAG, "createFile:filepath=" + filepath);

		byte[] buffer = new byte[1024];
		int length = 0;

		FileOutputStream fos;
		fos = new FileOutputStream(new File(filepath), true);
		try {
			while ((length = inputStream.read(buffer)) >= 0) {
				fos.write(buffer, 0, length);
			}
			Log.d(TAG, "createFile:success");
		} catch (Exception e) {
			Log.d(TAG, e.getMessage(), e);
		} finally {
			fos.flush();
			fos.close();
		}
	}

	private String postFile(String desturl, String paraname, String filepath)
			throws Exception {
		Log.d(TAG, "postFile:desturl=" + desturl + ",param=" + paraname
				+ ",filepath=" + filepath);

		HttpClient httpClient = new DefaultHttpClient();
		HttpPost post = new HttpPost(desturl);

		MultipartEntity entity = new MultipartEntity();
		entity.addPart(paraname, new FileBody(new File(filepath)));
		post.setEntity(entity);

		HttpResponse httpResponse = httpClient.execute(post);

		Log.d(TAG, "postFile:statuscode="
				+ httpResponse.getStatusLine().getStatusCode());
		if (httpResponse.getStatusLine().getStatusCode() == 201) {
			Log.d(TAG, "postFile:Location="
					+ httpResponse.getHeaders("Location")[0].getValue());
			return httpResponse.getHeaders("Location")[0].getValue();
		} else {
			throw new Exception("HTTP Response is not 201");
		}
	}
}
