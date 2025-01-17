import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/utilities/image_picker.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = '/productDetails';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  Image? _productImage;
  String _productName = '';
  String _price = '';
  String _desc = '';
  final category = ['Food', 'Shoes', 'Hostels', 'Others'];
  String? valueChosen;

  void pickImage() async {
    var image = await LocalImage(ImageSourceType.gallery).pickImage();
    setState(() {
      if (image != null) {
         _productImage = Image.file(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Product Details',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration:
                                kBoxDecoration.copyWith(color: kPrimaryColor1),
                            child: _productImage ??
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Product Image',
                                      style: kTextSytle2.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      hint: const Text(
                        'Select Category',
                        // style: GoogleFonts.quicksand(),
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      focusColor: kPrimaryColor1,
                      // dropdownColor: kPrimaryColor1,

                      isExpanded: true,
                      underline: SizedBox(),
                      value: valueChosen,
                      onChanged: (value) {
                        setState(() {
                          valueChosen = value as String?;
                        });
                      },
                      items: category
                          .map((valueItem) => DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryTextField(
                    labelText: 'Product name',
                    onSaved: (value) => _productName = value,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryTextField(
                    labelText: 'Price',
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _price = value,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MultiLineTextField(
                      labelText: 'Product Description',
                      onSaved: (value) => _desc = value),
                  Text(
                    'Description should not be more than 500 words',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff828282),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ReusableButton(
                    title: 'Add Products',
                    color: MaterialStateProperty.all(
                      kPrimaryColor1,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(
                            'product Name = $_productName and description = $_desc');
                        Navigator.pop(context);
                      }
                      // Navigator.pushNamed(context, HomePage.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
