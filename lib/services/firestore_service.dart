import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _productsCollection = 'products';

  Stream<List<Product>> getProducts() {
    return _firestore
        .collection(_productsCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Future version for one-time fetch
  Future<List<Product>> getProductsList() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(_productsCollection).get();
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      debugPrint('Error getting products: $e');
      return [];
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(_productsCollection).doc(id).get();

      if (doc.exists) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      // Use debugPrint instead of print for better practice
      debugPrint('Error getting product: $e');
      return null;
    }
  }

  // Helper method to add sample products (for testing)
  Future<void> addSampleProducts() async {
    final products = [
      {
        'name': 'iPhone 15 Pro',
        'description': 'Latest iPhone with A17 Pro chip and titanium design',
        'price': 999.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/007BFF/FFFFFF?text=iPhone+15+Pro',
      },
      {
        'name': 'Samsung Galaxy S24',
        'description': 'Flagship Android phone with AI features',
        'price': 899.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/28A745/FFFFFF?text=Galaxy+S24',
      },
      {
        'name': 'MacBook Air M3',
        'description': 'Ultra-thin laptop with M3 chip and all-day battery',
        'price': 1299.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/6C757D/FFFFFF?text=MacBook+Air',
      },
      {
        'name': 'iPad Pro 12.9"',
        'description':
            'Professional tablet with M2 chip and Liquid Retina display',
        'price': 1099.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/DC3545/FFFFFF?text=iPad+Pro',
      },
      {
        'name': 'AirPods Pro',
        'description': 'Wireless earbuds with active noise cancellation',
        'price': 249.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/FFC107/000000?text=AirPods+Pro',
      },
    ];

    for (var product in products) {
      await _firestore.collection(_productsCollection).add(product);
    }
  }

  // Helper method to add an extended product catalog (for testing)
  Future<void> addExtendedProductCatalog() async {
    final products = [
      // Electronics
      {
        'name': 'iPhone 15 Pro Max',
        'description':
            'The most advanced iPhone with titanium design and 48MP camera',
        'price': 1199.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/1E88E5/FFFFFF?text=iPhone+15+Pro+Max',
      },
      {
        'name': 'Samsung Galaxy S24 Ultra',
        'description': 'Premium Android phone with S Pen and 200MP camera',
        'price': 1299.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/4CAF50/FFFFFF?text=Galaxy+S24+Ultra',
      },
      {
        'name': 'Google Pixel 8 Pro',
        'description':
            'AI-powered smartphone with advanced computational photography',
        'price': 999.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/FF9800/FFFFFF?text=Pixel+8+Pro',
      },
      {
        'name': 'MacBook Pro 14" M3',
        'description':
            'Professional laptop with M3 Pro chip and Liquid Retina XDR display',
        'price': 1999.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/9C27B0/FFFFFF?text=MacBook+Pro+14',
      },
      {
        'name': 'MacBook Pro 16" M3 Max',
        'description': 'Ultimate creative powerhouse with M3 Max chip',
        'price': 2499.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/673AB7/FFFFFF?text=MacBook+Pro+16',
      },
      {
        'name': 'iPad Air 11"',
        'description': 'Versatile tablet with M2 chip and Apple Pencil support',
        'price': 599.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/00BCD4/FFFFFF?text=iPad+Air',
      },
      {
        'name': 'Apple Watch Ultra 2',
        'description': 'Rugged smartwatch for extreme sports and adventures',
        'price': 799.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/795548/FFFFFF?text=Watch+Ultra',
      },
      {
        'name': 'AirPods Max',
        'description': 'Premium over-ear headphones with spatial audio',
        'price': 549.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/607D8B/FFFFFF?text=AirPods+Max',
      },

      // Gaming
      {
        'name': 'PlayStation 5',
        'description': 'Next-gen gaming console with 4K gaming and SSD storage',
        'price': 499.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/2196F3/FFFFFF?text=PlayStation+5',
      },
      {
        'name': 'Xbox Series X',
        'description':
            'Powerful gaming console with 4K gaming and Quick Resume',
        'price': 499.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/4CAF50/FFFFFF?text=Xbox+Series+X',
      },
      {
        'name': 'Nintendo Switch Pro Controller',
        'description': 'Premium wireless controller for Nintendo Switch',
        'price': 69.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/F44336/FFFFFF?text=Pro+Controller',
      },
      {
        'name': 'Steam Deck',
        'description': 'Portable gaming PC for playing Steam games anywhere',
        'price': 399.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/FF5722/FFFFFF?text=Steam+Deck',
      },

      // Audio
      {
        'name': 'Sony WH-1000XM5',
        'description': 'Industry-leading noise canceling wireless headphones',
        'price': 399.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/9E9E9E/FFFFFF?text=Sony+WH1000XM5',
      },
      {
        'name': 'Bose QuietComfort 45',
        'description':
            'Comfortable noise-canceling headphones for all-day wear',
        'price': 329.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/3F51B5/FFFFFF?text=Bose+QC45',
      },
      {
        'name': 'JBL Charge 5',
        'description':
            'Portable Bluetooth speaker with powerful sound and long battery',
        'price': 179.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/FF9800/FFFFFF?text=JBL+Charge+5',
      },

      // Smart Home
      {
        'name': 'Amazon Echo Dot (5th Gen)',
        'description': 'Smart speaker with Alexa and improved sound quality',
        'price': 49.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/00BCD4/FFFFFF?text=Echo+Dot',
      },
      {
        'name': 'Google Nest Hub (2nd Gen)',
        'description': 'Smart display with Google Assistant and Sleep Sensing',
        'price': 99.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/4CAF50/FFFFFF?text=Nest+Hub',
      },
      {
        'name': 'Philips Hue Starter Kit',
        'description':
            'Smart LED bulbs with millions of colors and app control',
        'price': 199.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/E91E63/FFFFFF?text=Philips+Hue',
      },

      // Accessories
      {
        'name': 'Apple Magic Keyboard',
        'description':
            'Wireless keyboard with scissor mechanism and numeric keypad',
        'price': 199.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/607D8B/FFFFFF?text=Magic+Keyboard',
      },
      {
        'name': 'Logitech MX Master 3S',
        'description':
            'Advanced wireless mouse for productivity and creativity',
        'price': 99.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/795548/FFFFFF?text=MX+Master+3S',
      },
      {
        'name': 'Anker PowerCore 26800',
        'description': 'High-capacity portable charger for multiple devices',
        'price': 59.99,
        'imageUrl':
            'https://via.placeholder.com/300x300/2196F3/FFFFFF?text=PowerCore',
      },
    ];

    for (var product in products) {
      await _firestore.collection(_productsCollection).add(product);
    }
  }

  // Add a single product
  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection(_productsCollection).add(productData);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  // Update a product
  Future<void> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      await _firestore
          .collection(_productsCollection)
          .doc(productId)
          .update(productData);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(_productsCollection).doc(productId).delete();
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
