import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tomotoe_disease_detection_app/model/past_record.dart';
import 'package:tomotoe_disease_detection_app/service/past_record_db.dart';

class PastRecordsScreen extends StatefulWidget {
  const PastRecordsScreen({super.key});

  @override
  State<PastRecordsScreen> createState() => _PastRecordsScreenState();
}

class _PastRecordsScreenState extends State<PastRecordsScreen> {
  final PastRecordDatabase _database = PastRecordDatabase.instance;
  final DateFormat _dateFormat = DateFormat.yMMMd().add_jm();

  bool _isLoading = true;
  List<PastRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final records = await _database.fetchRecords();
    if (!mounted) return;
    setState(() {
      _records = records;
      _isLoading = false;
    });
  }

  Future<void> _deleteRecord(PastRecord record) async {
    if (record.id == null) return;
    await _database.deleteRecord(record.id!);
    if (!mounted) return;
    setState(() {
      _records = _records.where((r) => r.id != record.id).toList();
    });
  }

  Future<void> _deleteAllRecords() async {
    await _database.deleteAllRecords();
    if (!mounted) return;
    setState(() {
      _records = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
        actions: [
          if (_records.isNotEmpty)
            IconButton(
              tooltip: 'Clear all',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear history?'),
                    content: const Text(
                      'This will remove all saved diagnoses permanently.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await _deleteAllRecords();
                }
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? const _EmptyState()
              : RefreshIndicator(
                  onRefresh: _loadRecords,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: _records.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final record = _records[index];
                      return Dismissible(
                        key: ValueKey(record.id ?? record.imagePath),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD32F2F),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (_) => _deleteRecord(record),
                        child: _RecordTile(
                          record: record,
                          onDelete: () => _deleteRecord(record),
                          dateFormat: _dateFormat,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({
    required this.record,
    required this.onDelete,
    required this.dateFormat,
  });

  final PastRecord record;
  final VoidCallback onDelete;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final imageFile = File(record.imagePath);
    final confidencePercent = (record.confidence * 100).toStringAsFixed(1);
    final formattedDate = dateFormat.format(record.createdAt);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                imageFile,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 72,
                  height: 72,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.formattedLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Confidence $confidencePercent%',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No records yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Analyze a plant to see it appear here automatically.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

