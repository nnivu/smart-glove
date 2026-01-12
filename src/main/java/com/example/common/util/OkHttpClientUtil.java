package com.example.common.util;

import okhttp3.*;
import java.io.IOException;

public class OkHttpClientUtil {
    private static final OkHttpClient client = new OkHttpClient();

    public static String postJson(String url, String json, String apiKey) throws IOException {
        RequestBody body = RequestBody.create(json, MediaType.parse("application/json"));
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .addHeader("Authorization", "Bearer " + apiKey)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("API调用失败: " + response.code() + " " + response.message());
            }
            return response.body().string();
        }
    }
}