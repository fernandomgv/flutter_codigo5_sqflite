import 'package:flutter/material.dart';
import 'package:flutter_codig5_sqflite/db/db_admin.dart';
import 'package:flutter_codig5_sqflite/models/book_model.dart';
import 'package:flutter_codig5_sqflite/page/detail_page.dart';
import 'package:flutter_codig5_sqflite/ui/utils/colors.dart';
import 'package:flutter_codig5_sqflite/ui/widgets/info_perfil.dart';
import 'package:flutter_codig5_sqflite/ui/widgets/input_textfield_widget.dart';
import 'package:flutter_codig5_sqflite/ui/widgets/item_book_widget.dart';
import 'package:flutter_codig5_sqflite/ui/widgets/item_slider_widget.dart';
import 'package:flutter_codig5_sqflite/ui/widgets/textfield_search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];
  int idBook = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    BookModel miLibrito = BookModel(
      id: 10,
      title: "w1",
      author: "w2",
      description: "w3",
      image: "http",
    );

    Map<String, dynamic> miLibritoMap = {
      "id": 2,
      "title": "r1",
      "author": "r2",
      "description": "r3",
      "image": "https",
    };

    BookModel myBook = BookModel.fromJson(miLibritoMap);

    print(miLibrito.toJson());
  }

  getData() {
    DBAdmin.db.getBooks().then((value) {
      books = value;
      setState(() {});
    });
  }

  _showForm(bool add) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.66),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  add ? "Agregar libro" : "Actualizar libro",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Container(
                  width: 80.0,
                  height: 2.7,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                InputTextFieldWidget(
                  hintText: "T??tulo",
                  icon: "bx-bookmark",
                  controller: _titleController,
                ),
                InputTextFieldWidget(
                  hintText: "Autor",
                  icon: "bx-user",
                  controller: _authorController,
                ),
                InputTextFieldWidget(
                  hintText: "Descripci??n",
                  icon: "bx-list-ul",
                  maxLines: 2,
                  controller: _descriptionController,
                ),
                InputTextFieldWidget(
                  hintText: "Portada",
                  icon: "bx-images",
                  controller: _imageController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        BookModel book = BookModel(
                          title: _titleController.text,
                          author: _authorController.text,
                          description: _descriptionController.text,
                          image: _imageController.text,
                        );

                        if (add) {
                          DBAdmin.db.insertBook(book).then(
                                (value) {
                              if (value > 0) {
                                getData();
                                Navigator.pop(context);
                                _titleController.clear();
                                _authorController.clear();
                                _descriptionController.clear();
                                _imageController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xff1eb880),
                                    duration: const Duration(seconds: 3),
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "El libro fue agregado correctamente",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          book.id = idBook;

                          DBAdmin.db.updateBook(book).then((value) {
                            if (value > 0) {
                              getData();
                              Navigator.pop(context);
                              _titleController.clear();
                              _authorController.clear();
                              _descriptionController.clear();
                              _imageController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xff1eb880),
                                  duration: const Duration(seconds: 3),
                                  content: Row(
                                    children: const [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "El libro fue actualizado correctamente",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          });
                        }
                      },
                      child: Text(
                        "Aceptar",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDeleteDialog(BookModel book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10.0),
          backgroundColor: Color(0xffF53649),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Eliminar libro",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "??Est??s seguro de eliminar ${book.title} de tus libros?",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: GoogleFonts.poppins(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {

                      DBAdmin.db.deleteBook(book.id!).then((value) {
                        if(value>0){
                          getData();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xff1eb880),
                              duration: const Duration(seconds: 3),
                              content: Row(
                                children: const [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "El libro fue eliminado correctamente",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      "Aceptar",
                      style: GoogleFonts.poppins(
                        color: Color(0xffF53649),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _titleController.clear();
          _descriptionController.clear();
          _authorController.clear();
          _imageController.clear();
          _showForm(true);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoPerfil(),
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFieldSearch(),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mis Libros",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Ver m??s",
                      style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // FutureBuilder(
                //   future: DBAdmin.db.getBooks(),
                //   builder: (BuildContext context, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       List list = snap.data;
                //       return SingleChildScrollView(
                //         physics: const BouncingScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         child: Row(
                //           children: list
                //               .map(
                //                 (e) => ItemSliderWidget(
                //                   author: e["author"],
                //                   image: e["image"],
                //                   title: e["title"],
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       );
                //     }
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                // const SizedBox(
                //   height: 30.0,
                // ),
                // FutureBuilder(
                //   future: DBAdmin.db.getBooks(),
                //   builder: (BuildContext context, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       List list = snap.data;
                //       return Column(
                //         children: list
                //             .map(
                //               (e) => ItemBookWidget(
                //                 title: e["title"],
                //                 image: e["image"],
                //                 author: e["author"],
                //                 description: e["description"],
                //               ),
                //             )
                //             .toList(),
                //       );
                //       // return ListView.builder(
                //       //   shrinkWrap: true,
                //       //   itemCount: list.length,
                //       //   itemBuilder: (BuildContext coxtext, int index){
                //       //     return ItemBookWidget();
                //       //   },
                //       // );
                //     }
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: books
                        .map<Widget>(
                          (e) => GestureDetector(
                        onLongPress: () {
                          idBook = e.id!;
                          _titleController.text = e.title;
                          _authorController.text = e.author;
                          _descriptionController.text = e.description;
                          _imageController.text = e.image;
                          _showForm(false);
                        },
                        onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(book: e,)));
                            },
                        child: ItemSliderWidget(
                          model: e,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: books
                      .map<Widget>(
                        (BookModel e) => GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(book: e,)));
                          },
                          child: ItemBookWidget(
                      model: e,
                      onTap: () {
                          _showDeleteDialog(e);
                      },
                    ),
                        ),
                  )
                      .toList(),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),

      // body: ListView.builder(
      //   itemCount: books.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return ListTile(
      //       title: Text(books[index]["title"]),
      //     );
      //   },
      // ),
      // body: FutureBuilder(
      //   future: DBAdmin.db.getBooksRaw(),
      //   builder: (BuildContext context, AsyncSnapshot snap){
      //     if(snap.hasData){
      //       List bookList = snap.data;
      //       return ListView.builder(
      //         itemCount: bookList.length,
      //         itemBuilder: (BuildContext context, int index){
      //           return ListTile(
      //             title: Text(bookList[index]["title"]),
      //           );
      //         },
      //       );
      //     }
      //     return Text("ss");
      //   },
      // ),
    );
  }
}