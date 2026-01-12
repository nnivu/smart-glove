package com.example.service;

import com.example.entity.Deepseek;
import com.example.common.util.OkHttpClientUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.*;

@Service
@Slf4j // 添加日志支持
public class DeepSeekQuestionService {

    @Autowired
    private Deepseek deepseekConfig;

    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 单轮问答（带降级保护）
     */
    public String askQuestion(String question) throws IOException {
        return askQuestionWithHistory(question, null);
    }

    /**
     * 多轮对话（带降级保护）
     */
    public String askQuestionWithHistory(String question, List<Map<String, String>> history) throws IOException {
        // 参数校验
        if (question == null || question.trim().isEmpty()) {
            throw new IllegalArgumentException("问题不能为空");
        }

        try {
            // ===== 正常调用DeepSeek API =====
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", deepseekConfig.getModel());
            requestBody.put("temperature", 0.7);
            requestBody.put("max_tokens", 1024);

            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(Map.of("role", "system", "content", "你是一个专业的工业喷涂培训助手，回答简洁、专业。"));

            if (history != null && !history.isEmpty()) {
                messages.addAll(history);
            }

            messages.add(Map.of("role", "user", "content", question));
            requestBody.put("messages", messages);

            String jsonBody = objectMapper.writeValueAsString(requestBody);
            String fullUrl = deepseekConfig.getApiUrl() + "/chat/completions";
            String responseBody = OkHttpClientUtil.postJson(fullUrl, jsonBody, deepseekConfig.getApiKey());

            JsonNode root = objectMapper.readTree(responseBody);
            String answer = root.path("choices").get(0).path("message").path("content").asText();

            log.info("AI调用成功，问题: {}, 回答长度: {}", question, answer.length());
            return answer;

        } catch (Exception e) {
            // ===== 失败降级：返回本地预设答案 =====
            log.error("DeepSeek API调用失败，触发降级: {}", e.getMessage(), e);
            return getLocalFallbackAnswer(question);
        }
    }

    /**
     * 本地降级答案库
     * 根据用户问题关键词，返回预设答案
     */
    private String getLocalFallbackAnswer(String question) {
        String q = question.toLowerCase();

        // 姿态相关问题
        if (q.contains("姿态") || q.contains("姿势")) {
            return "【系统提示】AI服务暂时不可用。\n\n您可以参考以下建议改善喷涂姿态：\n" +
                    "1. 保持手臂与墙面呈45-60度角\n" +
                    "2. 手腕保持稳定，避免过度弯曲\n" +
                    "3. 身体距离墙面约30-50厘米\n" +
                    "4. 喷涂时保持匀速移动\n\n" +
                    "建议稍后再试AI分析服务。";
        }

        // 风险相关问题
        if (q.contains("风险") || q.contains("安全")) {
            return "【系统提示】AI服务暂时不可用。\n\n常见的喷涂风险包括：\n" +
                    "• 高空作业风险：确保脚手架稳固\n" +
                    "• 化学品风险：佩戴防护面罩和手套\n" +
                    "• 设备风险：定期检查喷枪压力\n\n" +
                    "请连接网络后重试AI风险评估。";
        }

        // 训练相关问题
        if (q.contains("训练") || q.contains("练习")) {
            return "【系统提示】AI服务暂时不可用。\n\n推荐训练流程：\n" +
                    "1. 基础动作练习（每天15分钟）\n" +
                    "2. 标准姿态模仿（对照视频）\n" +
                    "3. 实战模拟训练（虚拟场景）\n" +
                    "4. 错误回放纠正（查看历史记录）\n\n" +
                    "请稍后使用AI个性化训练建议。";
        }

        // 技术参数问题
        if (q.contains("压力") || q.contains("距离") || q.contains("角度")) {
            return "【系统提示】AI服务暂时不可用。\n\n标准喷涂参数参考：\n" +
                    "• 喷涂距离：25-30厘米\n" +
                    "• 喷涂角度：垂直于墙面（90°）\n" +
                    "• 喷枪压力：0.3-0.5 MPa\n" +
                    "• 移动速度：30-40 cm/s\n\n" +
                    "AI校准服务恢复后，可提供精确参数优化。";
        }

        // 通用降级回复
        return "【系统提示】AI服务暂时不可用。\n\n" +
                "您可以：\n" +
                "1. 检查网络连接\n" +
                "2. 稍后重试\n" +
                "3. 查看标准操作手册\n\n" +
                "如需帮助，请联系技术支持。";
    }
}