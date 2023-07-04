package com.reactnativecardscanner.cardmodules;

import android.graphics.Bitmap;

import java.util.List;

interface OnScanListener {
	void onPrediction(final CardScanned cardScanned);
  void onFatalError();
}
class CardScanned {
	public String number;
	public boolean didStartScan;

	public CardScanned(String num, boolean didStart) {
		number = num;
		didStartScan = didStart;
	}
}
