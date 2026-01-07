import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatAPI {
  Future<String> fetchAIResponse(
    List chatMap, {
    required double temperature,
    required double maxTokens,
    required int frequencyPenalty,
  }) async {
    // Replace this with your actual API Key
    const apiKey =
        "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";
    // URL for LLaMA 3 8B via DeepInfra
    const url = "https://openrouter.ai/api/v1/chat/completions";

    // Headers with your API key
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    // Payload with your message and model
    final payload = {
      "model": "mistralai/mistral-7b-instruct:free", // LLaMA 3 8B
      "messages": chatMap,
      "temperature": temperature,
      "max_tokens": maxTokens,
      "frequency_penalty": frequencyPenalty,
    };

    try {
      // Send the request//
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(payload))
          .timeout(const Duration(seconds: 40));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String reply = data["choices"][0]["message"]["content"];
        return reply;
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error : ${e.runtimeType}";
    }
  }
}

// PREVIOUS MODEL INFO:

// const url = "https://api.deepinfra.com/v1/openai/chat/completions";
// "model": "meta-llama/Meta-Llama-3-8B-Instruct"

// const url = "https://openrouter.ai/api/v1/chat/completions";
// "model": "deepseek/deepseek-r1:free",

// Good and free models :

// const url = "https://openrouter.ai/api/v1/chat/completions";
// "model": "meta-llama/llama-3.3-70b-instruct:free",
// "model": "mistralai/mistral-7b-instruct:free",
// "model": "deepseek/deepseek-chat-v3.1:free",
