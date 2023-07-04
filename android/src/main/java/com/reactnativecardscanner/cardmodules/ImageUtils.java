package com.reactnativecardscanner.cardmodules;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ImageUtils {

	public static Bitmap drawBoxesOnImage(Bitmap frame, List<DetectedBox> boxes, DetectedBox expiryBox) {
		Paint paint = new Paint(0);
		paint.setColor(Color.GREEN);
		paint.setStyle(Paint.Style.STROKE);
		paint.setStrokeWidth(3);

		Bitmap mutableBitmap = frame.copy(Bitmap.Config.ARGB_8888, true);
		Canvas canvas = new Canvas(mutableBitmap);
		for (DetectedBox box : boxes) {
			canvas.drawRect(box.getRect().getNewInstance(), paint);
		}

		paint.setColor(Color.RED);
		if (expiryBox != null) {
			canvas.drawRect(expiryBox.getRect().getNewInstance(), paint);
		}

		return mutableBitmap;
	}

	public static Bitmap cropImage(Bitmap frame, List<DetectedBox> boxes) {
		if (boxes.size() > 0) {
			CGRect firstCG = boxes.get(0).getRect();
			Bitmap bitmapCropped = Bitmap.createBitmap(frame, Math.round(firstCG.x), Math.round(firstCG.y), Math.round(firstCG.width), Math.round(firstCG.height));

			try {
				String filename = getFileName();
				File sd = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
				File dest = new File(sd, filename);

				FileOutputStream out = new FileOutputStream(dest);
				bitmapCropped.compress(Bitmap.CompressFormat.PNG, 100, out);
				out.flush();
				out.close();
				Log.d("KHOA", "ghi file thành công");
			} catch (Exception e) {
				Log.d("KHOA", "ghi file thắt bại" + e);
				e.printStackTrace();
			}

			return bitmapCropped;
		} else {
			return frame;
		}
	}

	public static String getFileName() {
		@SuppressLint("SimpleDateFormat") String timeStamp = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date());
		return "PNG_" + timeStamp + "_.png";
	}
}
