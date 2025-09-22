import 'package:hive/hive.dart';

class HiveService {
  final String _boxName = 'userBox';

  Future<Box> get _box async => await Hive.openBox(_boxName);
  // create
  Future<void> create(String value) async {
    Box box = await _box;
    await box.add(value);
  }
  // read
  Future<List> read() async {
    Box box = await _box;
    return box.values.toList();
  }
  //update
  Future<void> update(int index, String value) async {
    Box box = await _box;
    await box.putAt(index, value);
  }
  //delete
  Future<void> delete(int index) async {
    Box box = await _box;
    await box.deleteAt(index);
  }
}
