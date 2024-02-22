import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:relm/user%20home%20screens/database/db.dart';

ValueNotifier<List<AddNoteUser>> dataListNotifierNote = ValueNotifier([]);
Future<void> addNote(AddNoteUser value) async {
  final allDB = await Hive.openBox<AddNoteUser>('BookNote');
  try {
    final id = await allDB.add(value); // Add DataModel to Hive and get ID
    print('Added DataModel with ID: $id');

   
    AddNoteUser newValue = AddNoteUser(
        id:id,
        description: value.description,
        title: value.title
    );

    dataListNotifierNote.value = [
      ...dataListNotifierNote.value,
      newValue
    ]; 
    dataListNotifierNote.notifyListeners();
  } catch (e) {
    print('Error adding data: $e');
  } finally {
    await allDB.close();
  }
}
Future<void> getAllNote() async {
  final noteDB = await Hive.openBox<AddNoteUser>('BookNote');
  try {
    final List<AddNoteUser> notes = noteDB.values.toList();

  dataListNotifierNote.value = List<AddNoteUser>.from(notes);
 
   dataListNotifierNote.notifyListeners();
  } catch (e) {
    print('Error getting categories: $e');
  } finally {
    await noteDB.close();
  }
}
Future<void> DelNote(int id) async {
  final noteDB = await Hive.openBox<AddNoteUser>('BookNote');
  try {
    if (noteDB.isOpen) {
      await noteDB.delete(id);
      
      dataListNotifierNote.value.removeWhere((note) => note.id == id);
      dataListNotifierNote.notifyListeners();
    } else {
      print('Error: Box is not open or is null');
    }
  } catch (e) {
    print('Error deleting category: $e');
  } finally {
    await noteDB.close();
  }
}

// ValueNotifier<List<DataModel>> dataListNotifier = ValueNotifier([]);
// Future<void> addData(DataModel value) async {
//   final allDB = await Hive.openBox<DataModel>('relm');
//   try {
//     final id = await allDB.add(value); // Add DataModel to Hive and get ID
//     print('Added DataModel with ID: $id');

//     // Ensure proper initialization of DataModel instance with the returned ID
//     DataModel newValue = DataModel(
//       id: id,
//       uname: value.uname,
//       email: value.email,
//       password: value.password,
//       imageprof: value.imageprof,
//     );

//     dataListNotifier.value = [
//       ...dataListNotifier.value,
//       newValue
//     ]; // Update dataListNotifier
//     dataListNotifier.notifyListeners();
//   } catch (e) {
//     print('Error adding data: $e');
//   } finally {
//     await allDB.close();
//   }
// }

// Future<void> getAlldata() async {
//   final allDB = await Hive.openBox<DataModel>('relm');
//   try {
//     final dataList = List<DataModel>.from(allDB.values);

//     if (dataList.isNotEmpty && dataList.every((data) => data.id != null)) {
//       dataListNotifier.value = [...dataList];
//       dataListNotifier.notifyListeners();
//     } else {
//       print('');
//     }
//   } catch (e) {
//     print('Error getting data: $e');
//   } finally {
//     await allDB.close();
//   }
// }

// Future<bool> editData(int id, DataModel updatedData) async {
//   Box<DataModel>? allDB; // Declare allDB as nullable

//   try {
//     allDB = await Hive.openBox<DataModel>('relm');
//     final existingData = allDB.get(id);

//     if (existingData != null) {
//       // Create a new instance of DataModel with the original ID and updated data
//       DataModel newData = DataModel(
//         id: id,
//         uname: updatedData.uname,
//         email: updatedData.email,
//         password: updatedData.password,
//         imageprof: updatedData.imageprof,
//       );

//       // Update the data in the database
//       await allDB.put(id, newData);

//       // Update dataListNotifier with the updated data
//       int index = dataListNotifier.value.indexWhere((data) => data.id == id);
//       if (index != -1) {
//         dataListNotifier.value[index] = newData;
//         dataListNotifier.notifyListeners();
//       }
//       return true;
//     }
//     return false;
//   } finally {
//     if (allDB != null && allDB.isOpen) {
//       await allDB.close();
//     }
//   }
// }

// ValueNotifier<List<Datamodelcat>> dataListNotifiercat = ValueNotifier([]);

// Future<void> addCategoryAdmin(Datamodelcat details) async {
//   final catDB = await Hive.openBox<Datamodelcat>('relmcat');
//   try {
//     final id = await catDB.add(details);
//     details.id1 = id; // Assigning the ID after adding to the box
//     print('Added category with id: $id');
//     dataListNotifiercat.value.add(details);
//     dataListNotifiercat.notifyListeners();
//   } finally {
//     await catDB.close();
//   }
// }



// Future<void> DelCat(int id1) async {
//   final catDB = await Hive.openBox<Datamodelcat>('relmcat');
//   try {
//     if (catDB != null && catDB.isOpen) {
//       await catDB.delete(id1);
      
//       dataListNotifiercat.value.removeWhere((category) => category.id1 == id1);
//       dataListNotifiercat.notifyListeners();
//     } else {
//       print('Error: Box is not open or is null');
//     }
//   } catch (e) {
//     print('Error deleting category: $e');
//   } finally {
//     await catDB.close();
//   }
// }

// Future<bool> editCat(int id, Datamodelcat updatedData) async {
//   Box<Datamodelcat>? catDB;

//   try {
//     catDB = await Hive.openBox<Datamodelcat>('relmcat');
//     final existingData = catDB.get(id);

//     if (existingData != null) {
//       // Ensure ID consistency
//       updatedData.id1 = existingData.id1;

//       // Update the data in the database
//       await catDB.put(id, updatedData);

//       // Update dataListNotifiercat with the updated data
//       int index = dataListNotifiercat.value.indexWhere((data) => data.id1 == id);
//       if (index != -1) {
//         dataListNotifiercat.value[index] = updatedData;
//         dataListNotifiercat.notifyListeners();
//       }
//       return true;
//     } else {
//       print('Existing data is null');
//       return false;
//     }
//   } catch (e) {
//     print('Error updating data: $e');
//     return false;
//   } finally {
//     if (catDB != null && catDB.isOpen) {
//       await catDB.close();
//     }
//   }
// }
