import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/approval_bloc.dart';
import '../bloc/approval_event.dart';
import '../bloc/approval_state.dart';

class ApprovalDashboardPage extends StatelessWidget {
  const ApprovalDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ApprovalBloc>()..add(LoadPendingApprovals()),
      child: const _ApprovalDashboardView(),
    );
  }
}

class _ApprovalDashboardView extends StatelessWidget {
  const _ApprovalDashboardView();

  void _showRejectDialog(BuildContext context, String contentId) {
    final reasonController = TextEditingController();
    // Tangkap referensi Bloc sebelum masuk ke scope route dialog
    final approvalBloc = context.read<ApprovalBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tolak Konten'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: 'Masukkan alasan penolakan untuk OSIS',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  approvalBloc.add(
                    RejectContentSubmitted(
                      contentId: contentId,
                      reason: reason,
                    ),
                  );
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Tolak'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Guru'),
        centerTitle: true,
      ),
      body: BlocConsumer<ApprovalBloc, ApprovalState>(
        listener: (context, state) {
          if (state is ApprovalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ApprovalActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        buildWhen: (previous, current) {
          // Hanya rebuild jika state adalah Loading atau Loaded murni.
          // State ApprovalActionInProgress TIDAK AKAN men-trigger rebuild,
          // sehingga UX ListView tetap smooth dan posisinya tidak reset.
          return current is ApprovalLoading || current is ApprovalLoaded;
        },
        builder: (context, state) {
          if (state is ApprovalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ApprovalLoaded) {
            final approvals = state.approvals;
            
            if (approvals.isEmpty) {
              return const Center(
                child: Text('Tidak ada draf konten dari OSIS yang menunggu persetujuan.'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ApprovalBloc>().add(LoadPendingApprovals());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: approvals.length,
                itemBuilder: (context, index) {
                  final item = approvals[index];
                  final dateStr = item.submittedAt.toString().split(' ')[0];
                  
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Chip(
                                label: Text(item.mediaType),
                                backgroundColor: Colors.blue.shade100,
                                side: BorderSide.none,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Pengirim: ${item.submittedBy}'),
                          Text('Tanggal: $dateStr'),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                                onPressed: () => _showRejectDialog(context, item.id),
                                icon: const Icon(Icons.cancel),
                                label: const Text('Tolak'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  context.read<ApprovalBloc>().add(
                                    ApproveContentSubmitted(contentId: item.id),
                                  );
                                },
                                icon: const Icon(Icons.check_circle),
                                label: const Text('Setujui'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          
          return const Center(child: Text('Mempersiapkan...'));
        },
      ),
    );
  }
}
