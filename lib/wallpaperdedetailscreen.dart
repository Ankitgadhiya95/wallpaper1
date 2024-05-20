import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_it/share_it.dart';
import 'package:http/http.dart' as http;
import 'package:skyscrapper/skyapi.dart';
import 'package:uuid/uuid.dart';

class WallpaperDetailScreen extends StatefulWidget {
  WallpaperDetailScreen({super.key, required this.wall});

  final String wall;

  @override
  State<WallpaperDetailScreen> createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {

  Future<void> setWallpaperFromFileHome() async {
    // setState(() {
    //   _wallpaperFileHome = 'Loading';
    // });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.wall);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _wallpaperFileHome = result;
    // });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileLock() async {
    // setState(() {
    //   _wallpaperFileLock = 'Loading';
    // });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.wall);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _wallpaperFileLock = result;
    // });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileBoth() async {
    // setState(() {
    //   _wallpaperFileBoth = 'Loading';
    // });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.wall);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // // setState(() {
    //   _wallpaperFileBoth = result;
    // // });
  }



  Future<String> get _imageBundlePath async {
    final http.Response response = await http.get(Uri.parse(widget.wall));

    final dir = await getTemporaryDirectory();

    var uid = Uuid().v4();
    var filename = '${dir.path}/${uid}.png';

    final file = File(filename);
    await file.writeAsBytes(response.bodyBytes);
    return _fileFromBundle(name: 'image.png');
  }
  Future<String> _fileFromBundle({required String name}) async {
    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getTemporaryDirectory();
    if (directory == null) {
      return Future.error("null");
    }
    final filePath = join(directory.path, name);
    print(filePath);
    // final bundleData = await ;
    List<int> bytes = await File(filePath).readAsBytes();
    final file = await File(filePath).writeAsBytes(bytes);
    return file.path;
  }

  //Save Image

  Future<void> _saveImage(BuildContext context) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    print(widget.wall);
    try {
      final http.Response response = await http.get(Uri.parse(widget.wall));

      final dir = await getTemporaryDirectory();

      var filename = '${dir.path}/${Uuid().v4()}.png';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 33, 61, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async {

                ShareIt.file(
                    path: await _imageBundlePath, type: ShareItFileType.image);
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {

                _saveImage(context);

              },
              icon: Icon(Icons.download_sharp, color: Colors.white)),
          IconButton(
              onPressed: () {

                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            TextButton(onPressed: (){
                              setWallpaperFromFileLock();
                            }, child: Text("Lock Screen")),
                            TextButton(onPressed: (){
                              setWallpaperFromFileHome();
                            }, child: Text("home Screen")),
                            TextButton(onPressed: (){
                              setWallpaperFromFileBoth();
                            }, child: Text("both")),

                          ],
                        ),
                      ),
                    );
                  },
                );

              }, icon: Icon(Icons.image, color: Colors.white)),
        ],
        backgroundColor: Color.fromRGBO(40, 57, 94, 0),
        title: Text(
          "",
          style: TextStyle(color: Color.fromRGBO(252, 163, 17, 1)),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image(image: NetworkImage(widget.wall)),
      ),
    );
  }
}
