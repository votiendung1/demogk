import 'dart:io';
import 'package:demo_gk/components/my_textfield.dart';
import 'package:demo_gk/components/my_textfield1.dart';
import 'package:demo_gk/models/product.dart';
import 'package:demo_gk/services/database/firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RealtimeDatabaseService _realtimeDatabaseService =
      RealtimeDatabaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;
  String? _editingProductId;
  Product? _editingProduct; // Biến để lưu sản phẩm đang chỉnh sửa

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    String fileName = basename(image.path);
    Reference storageRef =
        FirebaseStorage.instance.ref().child('product_images/$fileName');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }

  Future<void> _saveProduct({bool isUpdate = false}) async {
    if (_nameController.text.isNotEmpty) {
      String imageUrl = _image != null ? await _uploadImage(_image!) : '';

      Product newProduct = Product(
        id: isUpdate
            ? _editingProductId!
            : _realtimeDatabaseService.productsRef.push().key!,
        name: _nameController.text,
        category: _categoryController.text,
        price: double.parse(_priceController.text),
        imageUrl: imageUrl,
      );

      if (isUpdate) {
        await _realtimeDatabaseService.updateProduct(newProduct);
      } else {
        await _realtimeDatabaseService.saveProduct(newProduct);
      }

      // Clear form after save or update
      _nameController.clear();
      _categoryController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
        _editingProductId = null;
        _editingProduct = null;
      });
    }
  }

  void _editProduct(Product product) {
    // Đưa dữ liệu sản phẩm lên form
    _nameController.text = product.name;
    _categoryController.text = product.category;
    _priceController.text = product.price.toString();
    _editingProductId = product.id;
    setState(() {
      _editingProduct = product;
      _image = null; // Có thể tải lại hình nếu cần
    });
    // print("Editing product image URL: ${product.imageUrl}"); // Kiểm tra URL
  }

  Future<void> _deleteProduct(String productId) async {
    await _realtimeDatabaseService.deleteProduct(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Dữ liệu sản phẩm"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Form nhập sản phẩm
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: MyTextfield(
                  controller: _nameController,
                  hintText: 'Tên sản phẩm',
                  obcureText: false,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: MyTextfield(
                  controller: _categoryController,
                  hintText: 'Loại sản phẩm',
                  obcureText: false,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: MyTextfield1(
                  controller: _priceController,
                  hintText: 'Giá',
                  obcureText: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20),
              // Hiển thị hình ảnh hiện tại của sản phẩm
              if (_editingProduct != null &&
                  _editingProduct!.imageUrl.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 2), // Viền với màu xám và độ dày 2
                    borderRadius: BorderRadius.circular(12), // Bo góc viền
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(_editingProduct!.imageUrl,
                        height: 150, fit: BoxFit.cover),
                  ),
                ),
              const SizedBox(height: 20),
              _image == null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _pickImage,
                      child: const Text(
                        "Chọn hình ảnh",
                        style: TextStyle(color: Colors.white),
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          Image.file(_image!, height: 150, fit: BoxFit.cover),
                    ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _saveProduct(isUpdate: _editingProductId != null);
                  },
                  child: Text(
                    _editingProductId != null
                        ? "Cập nhật sản phẩm"
                        : "Lưu sản phẩm",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(), // Dòng phân cách để phân biệt form và danh sách sản phẩm
              const SizedBox(height: 20),
              // Hiển thị danh sách sản phẩm ở cuối
              StreamBuilder<List<Product>>(
                stream: _realtimeDatabaseService.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Có lỗi xảy ra"));
                  }

                  final products = snapshot.data;

                  if (products == null || products.isEmpty) {
                    return const Center(child: Text("Không có sản phẩm nào"));
                  }

                  return ListView.builder(
                    shrinkWrap: true, // Để tránh cuộn hai lần
                    physics:
                        const NeverScrollableScrollPhysics(), // Không cuộn vì nằm trong SingleChildScrollView
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue,
                                width: 2), // Viền với màu xám và độ dày 2
                            borderRadius:
                                BorderRadius.circular(12), // Bo góc viền
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 254, 254),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: product.imageUrl.isNotEmpty
                                ? Image.network(product.imageUrl, width: 50)
                                : const Icon(Icons.image_not_supported),
                            title: Text(product.name),
                            subtitle: Text('Loại: ${product.category}\n'
                                'Giá: \$${product.price.toString()}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Nút sửa
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _editProduct(product);
                                  },
                                ),
                                // Nút xóa
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _deleteProduct(product.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
