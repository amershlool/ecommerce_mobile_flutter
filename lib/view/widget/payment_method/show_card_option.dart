import 'package:flutter/material.dart';

void showCardOption(BuildContext context, Map<String, String> card) {
  showModalBottomSheet(context: context, builder: (_) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    child:  Wrap(
      alignment:  WrapAlignment.center,
      children: [
        Text(
          card['holder'] ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit, color: Colors.blueAccent),
          title: const Text('تعديل البطاقة'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('سيتم فتح شاشة تعديل البطاقة ✏️'),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text('حذف البطاقة'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف البطاقة بنجاح 🗑️')),
            );
          },
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'إلغاء',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),

      ],
    ),
    );
  });
}