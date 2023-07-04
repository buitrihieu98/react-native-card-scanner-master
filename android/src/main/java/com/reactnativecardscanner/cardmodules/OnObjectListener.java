package com.reactnativecardscanner.cardmodules;

import android.graphics.Bitmap;

interface OnObjectListener {

	void onPrediction(final Bitmap bitmap, int imageWidth,
					  int imageHeight);

	void onObjectFatalError();

}
