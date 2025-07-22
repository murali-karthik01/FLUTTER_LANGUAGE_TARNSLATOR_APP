import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = "AIzaSyBQ_IPhkw7QicYyNsk9ij-L8DtTePiRHq0";

  String dropdownFrom = "English";
  String dropdownTo = "Nepali";
  String userInput = "";
  String result = "";
  bool isLoading = false;

  final FlutterTts flutterTts = FlutterTts();

  final Map<String, String> languageMap = {
    'English': 'en',
    'Nepali': 'ne',
    'Japanese': 'ja',
    'Korean': 'ko',
    'Spanish': 'es',
    'French': 'fr',
    'Hindi': 'hi',
    'Chinese': 'zh',
    'Telugu': 'te',
    'Tamil': 'ta',
  };

  Future<void> translateText() async {
    setState(() => isLoading = true);
    final url = Uri.parse(
        "https://translation.googleapis.com/language/translate/v2?key=$apiKey");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "q": userInput,
        "source": languageMap[dropdownFrom],
        "target": languageMap[dropdownTo],
        "format": "text",
        "key": apiKey,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        result = data["data"]["translations"][0]["translatedText"];
        isLoading = false;
      });
    } else {
      setState(() {
        result = "Error: ${data['error']['message']}";
        isLoading = false;
      });
    }
  }

  Future<void> speakText() async {
    await flutterTts.setLanguage(languageMap[dropdownTo]!);
    await flutterTts.setPitch(1);
    await flutterTts.speak(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text("🌍 AI Translator"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("From: "),
                        const SizedBox(width: 12),
                        DropdownButton<String>(
                          value: dropdownFrom,
                          items: languageMap.keys.map((String lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => dropdownFrom = val!),
                        ),
                        const Spacer(),
                        const Text("To: "),
                        const SizedBox(width: 12),
                        DropdownButton<String>(
                          value: dropdownTo,
                          items: languageMap.keys.map((String lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => dropdownTo = val!),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 5,
                      onChanged: (val) => userInput = val,
                      decoration: InputDecoration(
                        hintText: "Enter your text here...",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: isLoading ? null : translateText,
                      icon: const Icon(Icons.translate),
                      label: const Text("Translate"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (result.isNotEmpty)
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          result,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: speakText,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
