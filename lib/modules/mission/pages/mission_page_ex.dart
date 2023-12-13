// import 'dart:io';

// import 'package:crel_mobile/config/app_format.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// // class MissionPage extends StatefulWidget {
// //   const MissionPage({Key? key}) : super(key: key);

// //   @override
// //   State<MissionPage> createState() => _MissionPageState();
// // }

// // class _MissionPageState extends State<MissionPage> {
// //   List<String> items = [];
// //   File? image;
// //   final picker = ImagePicker();
// //   int page = 1;
// //   bool hasMore = true;
// //   bool isLoading = false;
// // //   Future<File> getImage() async {
// // //     final ImagePicker _picker = ImagePicker();
// // // // Pick an image
// // //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// // // //TO convert Xfile into file
// // //     File file = File(image!.path);
// // //     print("Image picked");
// // //     return file;
// // //   }

// //   Future getImage() async {
// //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

// //     setState(() {
// //       if (pickedFile != null) {
// //         image = File(pickedFile.path);
// //       } else {
// //         print('No image selected.');
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     controller.dispose();
// //   }

// //   final controller = ScrollController();
// //   // Future<void> uploadImage() async {}
// //   @override
// //   void initState() {
// //     super.initState();
// //     fetch();

// //     controller.addListener(() {
// //       if (controller.position.maxScrollExtent == controller.offset) {}
// //       fetch();
// //     });
// //   }

// //   Future fetch() async {
// //     if (isLoading) return;
// //     isLoading = true;
// //     final url = Uri.parse(
// //         "https://api.crel.site/api/v1.0/brands?PageNumber=$page&PageSize=6");
// //     final response = await http.get(url);
// //     if (response.statusCode == 200) {
// //       final List newItems = json.decode(response.body);
// //       setState(() {
// //         page++;
// //         isLoading = false;
// //         if (newItems.length < 5) {
// //           hasMore = false;
// //         }
// //         items.addAll(newItems.map<String>((item) {
// //           final number = item["name"];
// //           return 'Item $number';
// //         }).toList());
// //       });
// //     }
// //   }

// //   Future refresh() async {
// //     setState(() {
// //       isLoading = false;
// //       hasMore = true;
// //       page = 1;
// //       items.clear();
// //     });
// //     fetch();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(title: const Text("Nhiệm vụ")),
// //         body: RefreshIndicator(
// //           onRefresh: refresh,
// //           child: ListView.builder(
// //               controller: controller,
// //               padding: const EdgeInsets.all(8),
// //               itemCount: items.length + 1,
// //               itemBuilder: (context, index) {
// //                 if (index < items.length) {
// //                   final item = items[index];
// //                   return Column(
// //                     children: [
// //                       ListTile(
// //                         title: Text(
// //                           item,
// //                           style: TxtStyle.heading1,
// //                         ),
// //                       ),
// //                       const Icon(
// //                         Icons.abc,
// //                         size: 60,
// //                       )
// //                     ],
// //                   );
// //                 } else {
// //                   return Center(
// //                     child: hasMore
// //                         ? const CircularProgressIndicator()
// //                         : Container(),
// //                   );
// //                 }
// //               }),
// //         )
// //         // GestureDetector(
// //         //   onTap: () {
// //         //     getImage();
// //         //   },
// //         //   child: Container(
// //         //     height: 300,
// //         //     width: 300,
// //         //     decoration: BoxDecoration(
// //         //         borderRadius: BorderRadius.circular(200),
// //         //         color: Colors.grey[300],
// //         //         image: DecorationImage(
// //         //             image: (image != null)
// //         //                 ? FileImage(image!)
// //         //                 : const NetworkImage(
// //         //                         "https://i.pinimg.com/originals/d3/3e/44/d33e44debc8c2528e16fa3d52c5bdedc.png")
// //         //                     as ImageProvider,
// //         //             fit: BoxFit.cover)),
// //         //   ),
// //         // ),
// //         );
// //   }
// // }

// // class MissionPage extends StatefulWidget {
// //   const MissionPage({Key? key}) : super(key: key);

// //   @override
// //   State<MissionPage> createState() => _MissionPageState();
// // }

// // class _MissionPageState extends State<MissionPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("List Posts"),
// //       ),
// //       body: const PostBody(),
// //     );
// //   }
// // }

// // class PostBody extends StatefulWidget {
// //   const PostBody({Key? key}) : super(key: key);

// //   @override
// //   _PostBodyState createState() => _PostBodyState();
// // }

// // class _PostBodyState extends State<PostBody> {
// //   final ScrollController _scrollController = ScrollController();
// //   late PropertyForRentBloc _postBloc;
// //   List<PropertyForRent> items = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _postBloc = context.read<PropertyForRentBloc>();
// //     _scrollController.addListener(_onScroll);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
// //       builder: (context, state) {
// //         // post is initialize
// //         if (state is PropertyForRentLoading) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         // post is loaded
// //         if (state is PropertyForRentLoaded) {
// //           if (state.propertyForRents.isEmpty) {
// //             return const Center(
// //               child: Text("No Post"),
// //             );
// //           }
// //           return PropertyForRentList(
// //             scrollController: _scrollController,
// //             state: state,
// //           );

// //           // return RefreshIndicator(
// //           //   onRefresh: _onRefresh,
// //           //   child: PostList(
// //           //     scrollController: _scrollController,
// //           //     state: state,
// //           //   ),
// //           // );
// //         }

// //         // post is error
// //         return const Center(child: Text("Error Fetched Posts"));
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   // Future<void> _onRefresh() async {
// //   //   _postBloc..add(PostRefresh());
// //   // }

// //   void _onScroll() {
// //     double maxScroll = _scrollController.position.maxScrollExtent;
// //     double currentScroll = _scrollController.position.pixels;
// //     if (currentScroll == maxScroll) {
// //       _postBloc.add(GetPropertyForRentRequested());
// //     }
// //   }
// // }

// //**************************MAP************************** */

// // class MissionPage extends StatefulWidget {
// //   const MissionPage({Key? key}) : super(key: key);

// //   @override
// //   State<MissionPage> createState() => _MissionPageState();
// // }

// // class _MissionPageState extends State<MissionPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("List Posts"),
// //       ),
// //       body: const PostBody(),
// //     );
// //   }
// // }
// // class PostBody extends StatefulWidget {
// //   const PostBody({Key? key}) : super(key: key);

// //   @override
// //   _PostBodyState createState() => _PostBodyState();
// // }

// // class _PostBodyState extends State<PostBody> {
// //   var locationMessage = '';

// //   void getCurrentLocation() async {
// //     var position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high);
// //     var lat = position.latitude;
// //     var long = position.longitude;

// //     setState(() {
// //       locationMessage = "$position.latitude, $position.longitude";
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         FlutterMap(
// //           options: MapOptions(
// //               center: LatLng(10.853773683921245, 106.62795714591775), zoom: 13),
// //           layers: [
// //             TileLayerOptions(
// //                 urlTemplate:
// //                     "https://api.mapbox.com/styles/v1/dangminh200320/cl77tfno1000014nzk37ie17p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFuZ21pbmgyMDAzMjAiLCJhIjoiY2w3N2FudmZpMHlrdTN2cDh1bGFoMGlxdiJ9.l_z1dIp4SiWZnUl7Ht1fLQ",
// //                 additionalOptions: {
// //                   'accessToken':
// //                       'pk.eyJ1IjoiZGFuZ21pbmgyMDAzMjAiLCJhIjoiY2w3N2FudmZpMHlrdTN2cDh1bGFoMGlxdiJ9.l_z1dIp4SiWZnUl7Ht1fLQ',
// //                   'id': 'mapbox.mapbox-streets-v8'
// //                 }),
// //             MarkerLayerOptions(markers: [
// //               Marker(
// //                   point: LatLng(10.853773683921245, 106.62795714591775),
// //                   builder: (context) => Container(
// //                         child: IconButton(
// //                             onPressed: () {
// //                               print("marked");
// //                             },
// //                             icon: const Icon(Icons.location_on)),
// //                       ))
// //             ])
// //           ],
// //           nonRotatedChildren: [
// //             AttributionWidget.defaultWidget(
// //               source: 'OpenStreetMap contributors',
// //               onSourceTapped: null,
// //             ),
// //           ],
// //         ),

// //       ],
// //     );
// //   }
// // }

// class MissionPageEX extends StatefulWidget {
//   const MissionPageEX({Key? key}) : super(key: key);

//   @override
//   State<MissionPageEX> createState() => _MissionPageEXState();
// }

// class _MissionPageEXState extends State<MissionPageEX> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: PostBody(),
//       // backgroundColor: Colors.amber,
//       // body: const CustomCarousel(),
//     );
//   }
// }

// class PostBody extends StatefulWidget {
//   const PostBody({Key? key}) : super(key: key);

//   @override
//   _PostBodyState createState() => _PostBodyState();
// }

// class _PostBodyState extends State<PostBody> {
//   File? _pickedImage;
//   String outputText = "";

//   pickedImage(File file) {
//     setState(() {
//       _pickedImage = file;
//     });

//     InputImage inputImage = InputImage.fromFile(file);
//     //code to recognize image
//     processImageForConversion(inputImage);
//   }

//   processImageForConversion(inputImage) async {
//     setState(() {
//       outputText = "";
//     });

//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);

//     for (TextBlock block in recognizedText.blocks) {
//       if (AppFormat.nonUnicode(block.text).contains("cap ngay:")) {
//         var text = AppFormat.nonUnicode(block.text).trim().split(" ").last;
//         setState(() {
//           outputText += text + "\n";
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Image to Text")),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           pickImage(ImageSource.gallery, pickedImage);
//         },
//         child: const Icon(Icons.image),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           if (_pickedImage == null)
//             Container(
//               height: 300,
//               color: Colors.black,
//               width: double.infinity,
//             )
//           else
//             SizedBox(
//               height: 300,
//               width: double.infinity,
//               child: Image.file(
//                 _pickedImage!,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           // Expanded(child: Container()),
//           Text(
//             outputText,
//             style: const TextStyle(fontSize: 24),
//           ),
//           // Expanded(child: Container()),
//         ]),
//       ),
//     );

//     // IconButton(
//     //     onPressed: () async {
//     //       final result = await FilePicker.platform.pickFiles(
//     //         allowMultiple: true,
//     //         // type: FileType.custom,
//     //         // allowedExtensions: ['pdf', 'doc', 'docs']
//     //       );
//     //       if (result == null) return;

//     //       final file = result.files.first;

//     //       openFile(file);

//     //       // openFile(file);

//     //       // print("Name: ${file.name}");
//     //       // print("Byte: ${file.bytes}");
//     //       // print("Size: ${file.size}");
//     //       // print("Extension: ${file.extension}");
//     //       // print("Path: ${file.path}");
//     //       // final newFile = await saveFilePermanently(file);

//     //       // print("From path: ${file.path!}");
//     //       // print("To path: ${newFile.path}");
//     //     },
//     //     icon: const Icon(Icons.fiber_dvr)),
//     // ],
//     // );
//   }

//   void pickImage(source, Function(File) imgFile) async {
//     ImagePicker imgPicker = ImagePicker();

//     XFile? file = await imgPicker.pickImage(source: source);
//     if (file == null) return;
//     imgFile(File(file.path));
//   }

//   // void openFiles(List<PlatformFile> files) {
//   //   // OpenFile.open();
//   //   print("open");
//   // }

//   // void getImage(ImageSource source) async {
//   //   try {
//   //     final pickedImage =
//   //         await ImagePicker().pickImage(source: ImageSource.gallery);
//   //     if (pickedImage != null) {
//   //       textScanning = true;
//   //       imageFile = pickedImage;
//   //       setState(() {});
//   //       processImageForConversion(pickedImage);
//   //     }
//   //   } catch (e) {
//   //     textScanning = false;
//   //     imageFile = null;
//   //     setState(() {
//   //       scannedText = "Lỗi";
//   //     });
//   //   }
//   // }

//   // void getRecognisedText(XFile image) async {
//   //   // final inputImage = InputImage.fromFilePath(image.path);
//   //   // final textDetector = Goo
//   //   RecognizedText recognisedText = await textDetector.processImage(inputImage);
//   //   await textDetector.close();
//   //   scannedText = "";
//   //   for (TextBlock block in recognisedText.blocks) {
//   //     for (TextLine line in block.lines) {
//   //       scannedText = scannedText + line.text + "\n";
//   //     }
//   //   }
//   //   textScanning = false;
//   //   setState(() {});
//   // }

//   // void openFile(PlatformFile file) {
//   //   OpenFile.open(file.path);
//   //   // OpenDocument.openDocument(filePath: file.path!);
//   //   print("open");
//   // }

//   // Future<File> saveFilePermanently(PlatformFile file) async {
//   //   final appStorage = await getApplicationDocumentsDirectory();
//   //   final newFile = File('${appStorage.path}/${file.name}');
//   //   return File(file.path!).copy(newFile.path);
//   // }
// }
