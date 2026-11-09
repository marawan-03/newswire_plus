import 'package:intl/intl.dart';

String timeAgo(String text) {
  DateTime date = DateTime.parse(text).toLocal();
  final diff = DateTime.now().difference(date);

  if (diff.inMinutes <= 1) return 'الآن';
  if (diff.inMinutes == 2) return 'منذ دقيقتان';
  if (diff.inMinutes <=10 ) return 'منذ ${diff.inMinutes} دقائق';
  if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
  if (diff.inHours == 1) return 'منذ ساعة';
  if (diff.inHours == 2) return 'منذ ساعاتان';
  if (diff.inHours <= 10) return 'منذ ${diff.inHours} ساعات';
  if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
  if (diff.inDays == 1) return 'منذ يوم';
  if (diff.inDays == 2) return 'منذ يومان';
  if (diff.inDays < 7) return 'منذ ${diff.inDays} ايام ';
  return DateFormat('d MMMM y', 'ar').format(date);
}