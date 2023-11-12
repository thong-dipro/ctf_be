import 'package:models/models.dart';

class ProductMock {
  List<ProductModel> get getAllProduct => [
        const ProductModel(
          name: 'Stone',
          price: 1000,
          id: 1001,
          imageUrl:
              'https://i.pinimg.com/originals/4d/40/db/4d40dbef4879e329e9e9309ca3320470.png',
        ),
        const ProductModel(
          name: 'Copper',
          price: 3000,
          id: 1002,
          imageUrl:
              'https://i.pinimg.com/564x/89/04/75/89047514e3dd82fa52a11ab88e40a13b.jpg',
        ),
        const ProductModel(
          name: 'Gold',
          price: 5000,
          id: 1003,
          imageUrl: 'https://pngimg.com/d/gold_PNG10978.png',
        ),
        const ProductModel(
          name: 'Diamond',
          price: 10000,
          id: 1004,
          imageUrl:
              'https://i.pinimg.com/originals/ce/4d/da/ce4dda62943a0be6c3d8381673b8977b.png',
        ),
      ];
}
