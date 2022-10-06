import 'package:newravelinestore/data/model/cart_item_model.dart';
import 'package:newravelinestore/data/model/item_model.dart';
import 'package:newravelinestore/data/model/order_model.dart';
import 'package:newravelinestore/data/model/user_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/images/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/images/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/images/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/images/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/images/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/images/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

final List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  apple,
  papaya,
  mango,
  kiwi
];

// List of products
final List<String> categories = [
  'Fruits',
  'Grains',
  'Meats',
  'Vegetables',
  'Souces',
  'Cereals'
];

//List of carts
final List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 4),
  CartItemModel(item: guava, quantity: 1),
  CartItemModel(item: papaya, quantity: 3),
  CartItemModel(item: mango, quantity: 5),
  CartItemModel(item: grape, quantity: 4),
  CartItemModel(item: kiwi, quantity: 12),
];

//Test User
final genUser = UserModel(
  name: "Raveline",
  cpf: "11191151511",
  email: "raveline@email.com",
  phone: "3151515151",
  password: "passw",
);

//Testing Order Screen
final List<OrderModel> ordersModel = [
  OrderModel(
    id: 168152,
    dateCreated: DateTime.parse('2022-09-29 22:11:02'),
    dateOverdue: DateTime.parse('2022-09-30 23:11:02'),
    items: cartItems,
    status: 'pending_order',
    copyAndPaste: "6186161GVJHNJSN1615#",
    total: 120.30,
  ),
  OrderModel(
    id: 16515,
    dateCreated: DateTime.parse('2022-09-16 22:11:02'),
    dateOverdue: DateTime.parse('2022-09-17 23:11:02'),
    items: cartItems,
    status: 'refund_payment',
    copyAndPaste: "NSKJND6518615",
    total: 120.30,
  )
];
