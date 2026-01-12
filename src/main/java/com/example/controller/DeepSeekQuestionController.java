package com.example.controller;

import com.example.service.DeepSeekQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/deepseek") // ✅ 统一路径前缀
@CrossOrigin(origins = "*") // ✅ 添加跨域，允许前端调用
public class DeepSeekQuestionController {

    @Autowired
    private DeepSeekQuestionService deepSeekService; // ✅ 字段注入即可

    /**
     * 单轮问答接口
     */
    @PostMapping("/ask")
    public Map<String, Object> ask(@RequestBody Map<String, String> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            String question = request.get("question");
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
    @PostMapping("/chat")
    public Map<String, Object> chat(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            String question = (String) request.get("question");
            if (question == null || question.trim().isEmpty()) {
                response.put("code", 400);
                response.put("msg", "问题不能为空");
                return response;
            }

            @SuppressWarnings("unchecked")
            List<Map<String, String>> history = (List<Map<String, String>>) request.get("history");

            String answer = deepSeekService.askQuestionWithHistory(question, history);
            response.put("code", 200);
            response.put("msg", "success");
            response.put("data", answer);
        } catch (Exception e) {
            response.put("code", 500);
            response.put("msg", "获取回答失败: " + e.getMessage());
        }
        return response;
    }
}