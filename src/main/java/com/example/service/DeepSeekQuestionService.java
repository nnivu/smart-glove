package com.example.service;

import com.example.entity.Deepseek;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

@Service
public class DeepSeekQuestionService {

    // 注入你定义的Deepseek配置类（位于entity包下）
    @Autowired
    private Deepseek deepseekConfig;

    private final OkHttpClient client = new OkHttpClient();
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 单轮问答
     */
    public String askQuestion(String question) throws IOException {
        return askQuestionWithHistory(question, null);
    }

    /**
     * 多轮对话（带历史记录）
     */
    public String askQuestionWithHistory(String question, List<Map<String, String>> history) throws IOException {
        // 构建请求体（使用配置类中的参数）
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", deepseekConfig.getModel()); // 从配置类获取模型名
        requestBody.put("temperature", 0.7);
        requestBody.put("max_tokens", 1024);

        // 构建消息列表
        List<Map<String, String>> messages = new ArrayList<>();

        // 添加历史消息
        if (history != null && !history.isEmpty()) {
            messages.addAll(history);
        }

        // 添加当前问题
        Map<String, String> currentMessage = new HashMap<>();
        currentMessage.put("role", "user");
        currentMessage.put("content", question);
        messages.add(currentMessage);

        requestBody.put("messages", messages);

        // 转换为JSON
        String jsonBody = objectMapper.writeValueAsString(requestBody);

        // 创建请求（使用配置类中的API地址和密钥）
        Request request = new Request.Builder()
                .url(deepseekConfig.getApiUrl()) // 从配置类获取API地址
                .addHeader("Content-Type", "application/json")
                .addHeader("Authorization", "Bearer " + deepseekConfig.getApiKey()) // 从配置类获取API密钥
                .post(RequestBody.create(
                        jsonBody,
                        MediaType.parse("application/json")
                ))
                .build();

        // 发送请求并处理响应
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("API调用失败: " + response.code() + " " + response.message());
            }

            String responseBody = Objects.requireNonNull(response.body()).string();
            JsonNode jsonNode = objectMapper.readTree(responseBody);

            // 解析响应获取回答内容（根据DeepSeek API格式调整）
            return jsonNode.get("choices").get(0).get("message").get("content").asText();
        }
    }
}
