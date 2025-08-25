import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  print('📦 Lecture de la base Hive...');

  // 1. Initialiser Hive avec un chemin temporaire
  final dir = Directory('./temp_hive_dir');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  Hive.init(dir.path);

  // 2. Copier le fichier offline_relec_data.hive dans ce dossier
  final sourceFile = File('offline_relec_data.hive');
  final targetPath = path.join(dir.path, 'offline_relec_data.hive');
  await sourceFile.copy(targetPath);

  // 3. Ouvrir la boîte
  final box = await Hive.openBox('offline_relec_data');

  print('📄 Contenu de la boîte Hive :');
  for (var key in box.keys) {
    print('🔑 $key => ${box.get(key)}');
  }

  await box.close();
}
