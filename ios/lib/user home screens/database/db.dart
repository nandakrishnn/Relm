import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'db.g.dart';

@HiveType(typeId: 0)
  class DataModel{
    @HiveField(0)
    int? id;
    @HiveField(1)
  String? uname;
   @HiveField(2)
  String? email;
   @HiveField(3)
  String? password;
  @HiveField(4)
  String? imageprof;
 

  DataModel({
    this.id,
    @required this.uname,
    @required this.email,
    @required this.password,
     required this.imageprof
    
  });



  }
@HiveType(typeId: 1)
class Datamodelcat {
  @HiveField(0)
 
  int?id1;
  @HiveField(1)
  String catimage;
  @HiveField(2)
  String? catname;


  Datamodelcat({
     this.id1,
     required this.catimage,
     @required this.catname
  });

}




