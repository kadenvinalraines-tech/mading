import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/slider_bloc.dart';
import '../bloc/slider_event.dart';
import '../bloc/slider_state.dart';

class SliderManagementPage extends StatelessWidget {
  const SliderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<SliderBloc>()..add(const LoadSliders()),
      child: const _SliderManagementView(),
    );
  }
}

class _SliderManagementView extends StatelessWidget {
  const _SliderManagementView();

  void _showUploadDialog(BuildContext context) {
    // Tangkap BLoC dari context halaman (sebelum Navigator push route baru)
    final sliderBloc = context.read<SliderBloc>();
    
    final titleController = TextEditingController();
    final pathController = TextEditingController();
    final durationController = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unggah Konten'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul Konten'),
                ),
                const SizedBox(height: 16),
                // TODO: Nantinya akan diganti menggunakan file_picker atau image_picker
                TextField(
                  controller: pathController,
                  decoration: const InputDecoration(
                    labelText: 'Path File (Simulasi)',
                    hintText: '/storage/emulated/0/Download/gambar.jpg',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Durasi Tayang (Detik)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final duration = int.tryParse(durationController.text) ?? 10;
                
                // Dispatch Event
                sliderBloc.add(
                  UploadSliderSubmitted(
                    title: titleController.text,
                    filePath: pathController.text,
                    mediaType: 'image', // Hardcode sementara sesuai spesifikasi
                    durationSeconds: duration,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(days: 7)),
                  ),
                );
                
                Navigator.pop(context);
              },
              child: const Text('Unggah'),
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
        title: const Text('Manajemen Galeri Slider'),
        centerTitle: true,
      ),
      body: BlocConsumer<SliderBloc, SliderState>(
        listener: (context, state) {
          if (state is SliderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SliderActionSuccess) {
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
          // Ini memastikan SliderActionInProgress (saat upload) tidak mengganggu UX list.
          return current is SliderLoading || current is SliderLoaded;
        },
        builder: (context, state) {
          if (state is SliderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SliderLoaded) {
            if (state.sliders.isEmpty) {
              return const Center(child: Text('Belum ada konten slider yang ditambahkan.'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SliderBloc>().add(const LoadSliders());
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: state.sliders.length,
                itemBuilder: (context, index) {
                  final slider = state.sliders[index];
                  final isVideo = slider.mediaType.toLowerCase() == 'video';

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.withValues(alpha: 0.1),
                        child: Icon(
                          isVideo ? Icons.videocam : Icons.image,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        slider.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Durasi: ${slider.durationSeconds} detik\nStatus: ${slider.status.toUpperCase()}',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Tangkap BLoC untuk mencegah error Provider NotFound saat dialog ditekan
                          final sliderBloc = context.read<SliderBloc>();
                          
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Text('Hapus Konten?'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus konten ini dari layar Mading?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(dialogContext),
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      sliderBloc.add(
                                        DeleteSliderSubmitted(id: slider.id),
                                      );
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
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
        onPressed: () => _showUploadDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
