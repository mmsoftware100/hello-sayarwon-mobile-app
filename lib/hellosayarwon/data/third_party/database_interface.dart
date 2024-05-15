
import 'package:sqflite/sqflite.dart';

import '../../../core/error/exceptions.dart';

abstract class DatabaseInterface {
  // will return JSON raw data?
  // yeah,  child class have to return JSON / MAP
  Future<dynamic> getDetail({required String tableName,required int id, required Map<String,dynamic> query});
  Future<dynamic> getList({required String tableName,required Map<String,dynamic> query});
  Future<dynamic> store({required String tableName,required Map<String,dynamic> data});
  Future<dynamic> update({required String tableName,required int id,required Map<String,dynamic> data});
  Future<dynamic> delete({required String tableName,required int id});
}

class DatabaseInterfaceImpl implements DatabaseInterface{


  Database db;

  DatabaseInterfaceImpl({
    required this.db
  });


  @override
  Future delete({required String tableName, required int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getDetail({required String tableName, required int id, required Map<String, dynamic> query}) async{
    print("DatabaseInterface->getDetail $tableName for $id");
    try{
      if(query.isEmpty){
        List<Map> maps = await db.query(tableName,
            where: 'id = ?',
            whereArgs: [id]
        );

        print(maps);
        if(maps.isNotEmpty){
          return maps.first;
        }
        else{
          throw NoDataException();
        }
      }
      throw NoDataException();
    }
    catch(exp,stackTrace){
      print(exp);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future getList({required String tableName, required Map<String, dynamic> query}) async{
    try{

      List<Map> maps = await db.query(tableName,
        //where: where,
        // whereArgs:  whereArgs
      );

      return maps;

      // that's all

      if(query.isNotEmpty){
        // where , map ကို key1 = ?, key2 = ? ဒါမျိုး String ပြောင်း၇မယ်။ , မရှိတောင် အနည်းဆုံး page , id နဲ့ filter where statement ပါလား
        //

        // ဒါတွေက equal to တွေကိုပဲ စစ်ပေးမှာ ၊ တကယ်လိုချင်တာက ဒီထက်ပိုရှုပ်ထွေးတယ်။
        // အရှင်းဆုံးက API မှာ လိုမျိုးပဲ။ page, နဲ့ q လောက်ပဲ တွဲပေးနိုင်ရင် ပိုအဆင်ပြေနိုင်မယ်။
        // where သုံးခု project_id, category_id နဲ့ q
        // pagination က တစ်ခု q
        // နောက်ဆို where ထဲမှာ updated at ကိုမှ >= စတာတွေ လာဉီးမယ်။
        // ဘယ်လို လုပ်ရင် ကောင်းမလဲ?
        // String where = query.keys.map((e) => "$e = ? ").toList().join(",");
        // List<dynamic> whereArgs = query.values.toList();
        // select all သာ လုပ်လိုက်ပါတော့။ :D

        List<Map> maps = await db.query(tableName,
          //where: where,
          // whereArgs:  whereArgs
        );

        return maps;

      }
      else{

      }
      // columns: [columnId, columnDone, columnTitle],
      //where: '$columnId = ?',
      //whereArgs: [id]);
      /*
      if (maps.length > 0) {
        return Todo.fromMap(maps.first);
      }

           */
      //return null;
    }
    catch(exp,stackTrace){
      print(exp);
      print(stackTrace);
    }
  }

  @override
  Future store({required String tableName, required Map<String, dynamic> data}) async{
    // need to throw database exception , how to handle
    // so this is unified error handling without relying on third party database package
    // since they throw their own exception.

    try{
      int id = await db.insert(tableName, data);
      data['id'] = id;
      return data;
    }
    catch(exp, stackTrace){
      print(exp);
      print(stackTrace);
      throw Exception(exp.toString());
    }
  }

  @override
  Future update({required String tableName, required int id, required Map<String, dynamic> data}) async{
    try{
      int updatedId = await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
      return data;
    }
    catch(exp, stackTrace){
      print(exp);
      print(stackTrace);
      throw Exception(exp.toString());
    }

  }

}