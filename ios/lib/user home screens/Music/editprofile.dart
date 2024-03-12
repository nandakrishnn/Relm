import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditProfile extends StatefulWidget {
  // final DataModel userdata;

  EditProfile({
    Key? key,

  }) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  late TextEditingController updateuname;
  late TextEditingController updateemail;
  late TextEditingController updatepass;

  @override
  void initState() {
    super.initState();
  
    // super.initState();
    // updateuname = TextEditingController(text: widget.userdata.uname);
    // updateemail = TextEditingController(text: widget.userdata.email);
    // updatepass = TextEditingController(text: widget.userdata.password);
    // if (widget.userdata.imageprof != null &&
    //     widget.userdata.imageprof!.isNotEmpty) {
    //   image = File(widget.userdata.imageprof!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/total baground.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 64),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(
                            Icons.person,
                            size: 50.0,
                            color: Color.fromRGBO(11, 206, 131, 1),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: const Text(
                    'Change Image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
          
                  // child: ValueListenableBuilder(
                  //   valueListenable: dataListNotifier,
                  //   builder: (BuildContext ctx, List<DataModel> dataList,
                  //       Widget? child) {
                  //     if (dataList.isEmpty) {
                  //       return LinearProgressIndicator();
                  //     }
                  //     DataModel data = dataList.last;
                  //     return Column(
                  //       children: [
                  //         TextFormField(
                  //           controller: updateuname,
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             hintText: data.uname,
                  //             prefixIcon: const Icon(Icons.person),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         TextFormField(
                  //           controller: updateemail,
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             hintText: data.email,
                  //             prefixIcon: const Icon(Icons.person),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         TextFormField(
                  //           controller: updatepass,
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             hintText: data.password,
                  //             prefixIcon: const Icon(Icons.password),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 20,
                  //         ),
                  //         ElevatedButton(
                  //           onPressed: () async {
                  //             final uusername = updateuname.text;
                  //             final uemail = updateemail.text;
                  //             final upass = updatepass.text;

                  //             if (widget.userdata.id != null) {
                  //               final int id = widget.userdata.id!;
                  //               final data1 = DataModel(
                  //                 id: id,
                  //                 uname: uusername,
                  //                 email: uemail,
                  //                 password: upass,
                  //                 imageprof: image?.path ?? '',
                  //               );
                  //               await editData(id, data1);
                  //               Navigator.pop(context);
                  //             }
                  //             ButtonStyle(
                  //                 shadowColor: MaterialStatePropertyAll(
                  //                     Color.fromRGBO(255, 13, 13, 0.984)));
                  //           },
                  //           child: const Text(
                  //             'Update',
                  //             style: TextStyle(
                  //                 color: Color.fromRGBO(63, 63, 63, 0.984)),
                  //           ),
                  //         )
                  //       ],
                  //     );
                  //   },
                  // ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      image = File(pickedFile.path);
    });
  }
}
