class WebNode {
  final int value;
  final double xPercent; // نسبة أفقية من 0.0 لـ 1.0
  final double yPercent; // نسبة عمودية من 0.0 لـ 1.0

  const WebNode({
    required this.value,
    required this.xPercent,
    required this.yPercent,
  });
}

// المواقع المقترحة (أزواج متقابلة عبر المركز)
// هاي أرقام تقريبية هلق - رح نظبطهم سوا بعد ما نشوفهم عالصورة الحقيقية
const List<WebNode> webNodes = [
  WebNode(value: 0, xPercent: 0.50, yPercent: 0.115),
  WebNode(value: 10, xPercent: 0.50, yPercent: 0.545),
  WebNode(value: 1, xPercent: 0.735, yPercent: 0.175),
  WebNode(value: 9, xPercent: 0.30, yPercent: 0.62),
  WebNode(value: 2, xPercent: 0.895, yPercent: 0.34),
  WebNode(value: 8, xPercent: 0.135, yPercent: 0.50),
  WebNode(value: 3, xPercent: 0.88, yPercent: 0.60),
  WebNode(value: 7, xPercent: 0.145, yPercent: 0.30),
  WebNode(value: 4, xPercent: 0.735, yPercent: 0.80),
  WebNode(value: 6, xPercent: 0.27, yPercent: 0.14),
  WebNode(value: 5, xPercent: 0.50, yPercent: 0.86),
];