package com.tealeaf.plugin.plugins;

import com.tealeaf.logger;
import com.tealeaf.plugin.IPlugin;
import java.io.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.Iterator;

import com.trademob.tracking.api.TMUniversalTracking;

import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.util.Log;
import android.os.Bundle;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;

public class TradeMobPlugin implements IPlugin {

	TMUniversalTracking tracker;

	public TradeMobPlugin() {
	}

	public void onCreateApplication(Context applicationContext) {
	}

	public void onCreate(Activity activity, Bundle savedInstanceState) {
		logger.log("{tradeMob} Initializing with activity");

		tracker = TMUniversalTracking.getTracker();
		tracker.debugMode();
		tracker.initialise(activity);
		tracker.trackAppload();
	}

    public void track(String json) {
        String eventName = "noName";
        try {
            JSONObject obj = new JSONObject(json);
            eventName = obj.getString("eventName");
            JSONObject paramsObj = obj.getJSONObject("params");
            Iterator<String> iter = paramsObj.keys();

			String value = paramsObj.toString();
			tracker.trackActionAlways(eventName, 0, value);

			logger.log("{tradeMob} track - success:", eventName, "subId=", value);
        } catch (JSONException e) {
            logger.log("{tradeMob} track - failure: " + eventName + " - " + e.getMessage());
        }
    }

	public void onResume() {
	}

	public void onStart() {
	}

	public void onPause() {
	}

	public void onStop() {
	}

	public void onDestroy() {
	}

	public void onNewIntent(Intent intent) {
	}

	public void setInstallReferrer(String referrer) {
	}

	public void onActivityResult(Integer request, Integer result, Intent data) {
	}

	public boolean consumeOnBackPressed() {
		return true;
	}

	public void onBackPressed() {
	}
}
