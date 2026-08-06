import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/running_text_bloc.dart';
import '../bloc/running_text_event.dart';
import '../bloc/running_text_state.dart';

class RunningTextManagementPage extends StatelessWidget {
  const RunningTextManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<RunningTextBloc>()..add(const LoadRunningTexts()),
      child: const _RunningTextManagementView(),
    );
  }
}

class _RunningTextManagementView extends StatelessWidget {
  const _RunningTextManagementView();

  void _showAddTextDialog(BuildContext context) {
    // Tangkap BLoC untuk mencegah error Provider NotFound saat dialog ditutup/dibuka
    final runningTextBloc = context.read<RunningTextBloc>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Teks Berjalan'),
          content: TextField(
            controller: textController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Contoh: Pengingat Ujian Tengah Semester dimulai besok...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = textController.text.trim();
                if (text.isNotEmpty) {
                  runningTextBloc.add(AddRunningTextSubmitted(text: text));
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('Simpan'),
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
        title: const Text('Manajemen Teks Berjalan'),
        centerTitle: true,
      ),
      body: BlocConsumer<RunningTextBloc, RunningTextState>(
        listener: (context, state) {
          if (state is RunningTextError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is RunningTextActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        buildWhen: (previous, current) {
          // Hanya render ulang list jika state Loading atau Loaded.
          // Mencegah kedip (flicker) saat status ActionInProgress memproses unggah/hapus.
          return current is RunningTextLoading || current is RunningTextLoaded;
        },
        builder: (context, state) {
          if (state is RunningTextLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RunningTextLoaded) {
            if (state.runningTexts.isEmpty) {
              return const Center(
                child: Text('Belum ada teks berjalan. Silakan tambah baru.'),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RunningTextBloc>().add(const LoadRunningTexts());
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: state.runningTexts.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = state.runningTexts[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.closed_caption),
                    ),
                    title: Text(item.text),
                    subtitle: Text('Status: ${item.isActive ? 'Aktif' : 'Tidak Aktif'}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        context.read<RunningTextBloc>().add(
                          DeleteRunningTextSubmitted(id: item.id),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Menyiapkan data...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTextDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
