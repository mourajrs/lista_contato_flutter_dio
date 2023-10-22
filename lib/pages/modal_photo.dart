import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:listacontatos/model/contato_model.dart';
import 'package:listacontatos/repository/back4app_repository.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listacontatos/Theme/theme.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';

class ChangePhotoWidget extends StatefulWidget {
  const ChangePhotoWidget({Key? key}) : super(key: key);

  @override
  _ChangePhotoWidgetState createState() => _ChangePhotoWidgetState();
}

class _ChangePhotoWidgetState extends State<ChangePhotoWidget> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final focus = FocusNode();
  File? imagePath;
  XFile? photo;
  Back4appRepository repository = Back4appRepository();

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
      setState(() {});
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: ThemeCustom.of(context).secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 3,
                            indent: 150,
                            endIndent: 150,
                            color: ThemeCustom.of(context).primaryBackground,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFDBE2E7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: (photo == null)
                                              ? Image.network(
                                                  'https://images.unsplash.com/photo-1549845375-ce0a0ba8288c?auto=format&fit=crop&q=80&w=2119&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(photo!.path),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                              ElevatedButton(
                                child: const Text("Adicionar foto"),
                                onPressed: () async {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Wrap(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title: const Text("Camera"),
                                              onTap: () async {
                                                final ImagePicker _picker = ImagePicker();
                                                photo = await _picker.pickImage(source: ImageSource.camera);
                                                if (photo != null) {
                                                  String path = (await path_provider.getApplicationDocumentsDirectory()).path;
                                                  String name = p.basename(photo!.path);
                                                  await photo!.saveTo("$path/$name");

                                                  await GallerySaver.saveImage(photo!.path);
                                                  setState(() {});

                                                  Navigator.pop(context);

                                                  cropImage(photo!);
                                                }
                                              },
                                            ),
                                            ListTile(
                                                leading: const Icon(Icons.image_search),
                                                title: const Text("Galeria"),
                                                onTap: () async {
                                                  final ImagePicker _picker = ImagePicker();
                                                  photo = await _picker.pickImage(source: ImageSource.gallery);
                                                  Navigator.pop(context);
                                                  setState(() {});

                                                  cropImage(photo!);
                                                })
                                          ],
                                        );
                                      });
                                },
                              ),
                            ]),
                          ),
                          SingleChildScrollView(
                              child: Column(
                            children: [
                              TextField(
                                controller: _controllerNome,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (value) {
                                  _controllerNome.text = value;
                                  FocusScope.of(context).requestFocus(focus);
                                },
                                decoration: const InputDecoration(
                                  label: Text("Nome"),
                                ),
                              ),
                              TextField(
                                controller: _controllerTelefone,
                                focusNode: focus,
                                // textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                maxLength: 11,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) {
                                  _controllerTelefone.text = value;
                                  FocusScope.of(context).nextFocus();
                                },
                                decoration: const InputDecoration(
                                  label: Text("Telefone"),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  repository
                                      .criar(ContatoModel(nome: _controllerNome.text, imagePath: photo!.path, telefone: _controllerTelefone.text)),
                                  Navigator.pop(context)
                                },
                                child: const Text("Salvar"),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancelar"),
                              ),
                            ],
                          )),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
