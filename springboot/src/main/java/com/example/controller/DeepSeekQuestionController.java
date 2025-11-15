package com.example.controller;

import com.example.service.DeepSeekQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class  DeepSeekQuestionController {

    // 推荐使用构造器注入（而非字段注入）
    private final DeepSeekQuestionService deepSeekService;

    @Autowired
    public DeepSeekQuestionController(DeepSeekQuestionService deepSeekService) {
        this.deepSeekService = deepSeekService;
    }

    /**
     * 单轮问答接口
     */
    @PostMapping("/api/deepseek/ask")
    public Map<String, Object> ask(@RequestBody Map<String, String> request) {
        // 使用统一的响应格式，便于前端处理
        Map<String, Object> response = new HashMap<>();

        try {
            String question = request.get("question");
            // 校验参数
            if (question == null || question.trim().isEmpty()) {
                response.put("code", 400);
                response.put("msg", "问题不能为空");
                return response;
            }

            String answer = deepSeekService.askQuestion(question);
            response.put("code", 200);
            response.put("msg", "success");
            response.put("data", answer);
        } catch (IOException e) {
            response.put("code", 500);
            response.put("msg", "获取回答失败: " + e.getMessage());
        }

        return response;
    }

    /**
     * 多轮对话接口
     */
    @PostMapping("/api/deepseek/chat")
    public Map<String, Object> chat(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 提取并校验参数
            String question = (String) request.get("question");
            if (question == null || question.trim().isEmpty()) {
                response.put("code", 400);
                response.put("msg", "问题不能为空");
                return response;
            }

            // 安全处理历史记录类型转换
            List<Map<String, String>> history = null;
            Object historyObj = request.get("history");
            if (historyObj instanceof List<?>) {
                history = (List<Map<String, String>>) historyObj;
            }

            String answer = deepSeekService.askQuestionWithHistory(question, history);
            response.put("code", 200);
            response.put("msg", "success");
            response.put("data", answer);
        } catch (ClassCastException e) {
            response.put("code", 400);
            response.put("msg", "历史记录格式错误");
        } catch (IOException e) {
            response.put("code", 500);
            response.put("msg", "获取回答失败: " + e.getMessage());
        }

        return response;
    }
}
