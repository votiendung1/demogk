import 'package:demo_gk/models/product.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final DatabaseReference productsRef = FirebaseDatabase.instance.ref('products');

  // Thêm sản phẩm
  Future<void> saveProduct(Product product) async {
    await productsRef.child(product.id).set(product.toMap());
  }

  // Cập nhật sản phẩm
  Future<void> updateProduct(Product product) async {
    await productsRef.child(product.id).update(product.toMap());
  }

  // Xóa sản phẩm
  Future<void> deleteProduct(String productId) async {
    await productsRef.child(productId).remove();
  }

  // Lấy tất cả sản phẩm (dùng stream để cập nhật real-time)
  Stream<List<Product>> getProducts() {
  return productsRef.onValue.map((event) {
    final data = event.snapshot.value as Map?;
    if (data == null) return <Product>[];
    
    try {
      return data.entries.map((e) {
        return Product.fromMap(Map<String, dynamic>.from(e.value), e.key);
      }).toList();
    } catch (e) {
      print("Error parsing products: $e");
      return <Product>[]; // Trả về danh sách trống nếu có lỗi parsing
    }
  });
}

}
