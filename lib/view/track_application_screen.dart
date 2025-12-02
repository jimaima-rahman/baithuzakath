import 'package:baithuzakath_app/models/applocation_track_model.dart';
import 'package:baithuzakath_app/providers/track_application_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationTrackScreen extends ConsumerWidget {
  final String applicationId;

  const ApplicationTrackScreen({Key? key, required this.applicationId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingData = ref.watch(applicationTrackProvider(applicationId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Application'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(applicationTrackProvider(applicationId));
            },
          ),
        ],
      ),
      body: trackingData.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error.toString(), ref),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ApplicationTrackModel data) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh will be handled by the rebuild
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(context, data),
            const SizedBox(height: 16),
            _buildTimeline(context, data),
            const SizedBox(height: 16),
            _buildDetailsCard(context, data),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ApplicationTrackModel data) {
    // Adjust these based on your ApplicationTrackModel structure
    final status = data.data?.application?.status ?? 'Unknown';
    final applicationNumber =
        data.data?.application?.applicationNumber ?? 'N/A';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Application #$applicationNumber',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your application status',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, ApplicationTrackModel data) {
    final timeline = _getTimelineSteps(data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Application Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...timeline.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                final isLast = index == timeline.length - 1;
                return _buildTimelineItem(
                  context,
                  step['title']!,
                  step['subtitle']!,
                  step['isCompleted'] == 'true',
                  step['isCurrent'] == 'true',
                  isLast,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getTimelineSteps(ApplicationTrackModel data) {
    final status = data.data?.application?.status.toLowerCase() ?? '';

    return [
      {
        'title': 'Submitted',
        'subtitle': data.data?.application?.status ?? 'Pending',
        'isCompleted': 'true',
        'isCurrent': status == 'submitted' ? 'true' : 'false',
      },
      {
        'title': 'Under Review',
        'subtitle': data.data?.application?.status ?? 'Pending',
        'isCompleted': ['under_review', 'approved', 'rejected'].contains(status)
            ? 'true'
            : 'false',
        'isCurrent': status == 'under_review' ? 'true' : 'false',
      },
      {
        'title': 'Approved',
        'subtitle':
            data.data?.application?.approvedAmount.toString() ?? 'Pending',
        'isCompleted': status == 'approved' ? 'true' : 'false',
        'isCurrent': status == 'approved' ? 'true' : 'false',
      },
    ];
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String title,
    String subtitle,
    bool isCompleted,
    bool isCurrent,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? Colors.green
                    : isCurrent
                    ? Colors.blue
                    : Colors.grey.shade300,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : isCurrent
                    ? Icons.circle
                    : Icons.circle_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: isCompleted
                    ? Colors.green.shade200
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCompleted || isCurrent
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(BuildContext context, ApplicationTrackModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Application Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                'Application ID',
                data.data?.application?.id ?? 'N/A',
                Icons.tag,
              ),
              _buildDetailRow(
                'Application Number',
                data.data?.application?.applicationNumber ?? 'N/A',
                Icons.numbers,
              ),
              _buildDetailRow(
                'Status',
                data.data?.application?.status ?? 'N/A',
                Icons.info_outline,
              ),
              if (data.data?.application?.scheme.name != null)
                _buildDetailRow(
                  'Scheme',
                  data.data?.application?.scheme.name ?? 'N/A',
                  Icons.folder_outlined,
                ),
              if (data.data?.application?.requestedAmount != null)
                _buildDetailRow(
                  'Requested Amount',
                  '₹${data.data?.application?.requestedAmount.toStringAsFixed(2)}',
                  Icons.currency_rupee,
                ),
              if (data.data?.application?.approvedAmount != null)
                _buildDetailRow(
                  'Approved Amount',
                  '₹${data.data?.application?.approvedAmount.toStringAsFixed(2)}',
                  Icons.check_circle_outline,
                ),
              // if (data.data?.application?.status != null && data.data?.remarks != null && data.data!.remarks!.isNotEmpty)
              // Padding(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'Remarks',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black87,
              //         ),
              //       ),
              //       const SizedBox(height: 8),
              //       Container(
              //         padding: const EdgeInsets.all(12),
              //         decoration: BoxDecoration(
              //           color: Colors.blue.shade50,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Text(
              //           data.remarks!,
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: Colors.grey.shade700,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.blue.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            const Text(
              'Error Loading Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error.replaceAll('Exception: ', ''),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(applicationTrackProvider(applicationId));
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
