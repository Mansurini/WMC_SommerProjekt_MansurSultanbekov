import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

Future<String?> fetchOpenGraphImage(String url) async {
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      },
    );

    if (response.statusCode != 200) return null;

    final document = html.parse(response.body);

    final ogImage = document
        .querySelectorAll('meta[property="og:image"]')
        .map((x) => x.attributes['content'])
        .firstWhere((x) => x != null, orElse: () => null);

    if (ogImage != null) return ogImage;

    final twitterImage = document
        .querySelectorAll('meta[name="twitter:image"]')
        .map((x) => x.attributes['content'])
        .firstWhere((x) => x != null, orElse: () => null);

    if (twitterImage != null) return twitterImage;

    return null;
  } catch (e) {
    return e.toString();
  }
}
