package com.reactlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import zendesk.core.AnonymousIdentity;
import zendesk.core.Identity;
import zendesk.core.Zendesk;
import zendesk.support.Support;
import zendesk.support.guide.HelpCenterActivity;
import zendesk.support.request.RequestActivity;
import zendesk.support.requestlist.RequestListActivity;

public class SohZdeskModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public SohZdeskModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "SohZdesk";
    }

    @ReactMethod
    public void init(String appId, String clientId, String zendeskUrl) {
        Zendesk.INSTANCE.init(getCurrentActivity(), zendeskUrl, appId, clientId);
        Support.INSTANCE.init(Zendesk.INSTANCE);
    }
    @ReactMethod
    public void initUser(String name, String email, String phone) {
        Identity identity = new AnonymousIdentity.Builder()
                .withNameIdentifier(name)
                .withEmailIdentifier(email)
                .build();
        Zendesk.INSTANCE.setIdentity(identity);
        Zendesk.INSTANCE.provider().pushRegistrationProvider().registerWithDeviceIdentifier(result, new ZendeskCallback<String>() {});
    }
    @ReactMethod
    public void openHelpCenter() {
        HelpCenterActivity.builder().show(getCurrentActivity());
    }
    @ReactMethod
    public void openContactUs() {
        RequestActivity.builder()
                .show(getCurrentActivity());
    }
    @ReactMethod
    public void openTickets() {
        RequestListActivity.builder()
                .show(getCurrentActivity());

    }

}
