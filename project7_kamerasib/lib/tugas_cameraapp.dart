import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isCameraReady = false;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      controller = CameraController(cameras![selectedCameraIndex], ResolutionPreset.medium);
      await controller!.initialize();
      setState(() {
        isCameraReady = true;
      });
    }
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    await controller?.dispose();

    controller = CameraController(cameras![selectedCameraIndex], ResolutionPreset.medium);
    await controller!.initialize();
    setState(() {});
  }

 Future<void> takePicture() async {
  if (!controller!.value.isInitialized) return;

  final Directory? dir = await getExternalStorageDirectory();
  if (dir == null) return;

  final Directory fotoDir = Directory('${dir.path}/foto_kamera');
  if (!await fotoDir.exists()) {
    await fotoDir.create(recursive: true);
  }

  final String filePath =
      '${fotoDir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

  XFile image = await controller!.takePicture();
  await image.saveTo(filePath);

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Foto tersimpan di: $filePath')),
    );

    // Navigasi ke halaman preview
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Hasil Foto')),
          body: Center(child: Image.file(File(filePath))),
        ),
      ),
    );
  }

  debugPrint('Gambar disimpan di: $filePath');
}


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraReady || controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pratinjau Kamera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: switchCamera,
          ),
        ],
      ),
      body: CameraPreview(controller!),
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
