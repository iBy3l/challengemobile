import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final String name;
  final String image;

  const CardModel({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];

  static List<CardModel> cardModel = [
    const CardModel(
      name: 'A arte da guerra',
      image: 'https://m.media-amazon.com/images/I/51drYBDrAvL.jpg',
    ),
    const CardModel(
      name: 'Parkour',
      image:
          'https://image.winudf.com/v2/image/Y29tLmFuZHJvbW8uZGV2NjM3NjcyLmFwcDc5ODQxMl9zY3JlZW5fM18xNTMxNTY0NDE4XzAyOA/screen-3.jpg?fakeurl=1&type=.webp',
    ),
    const CardModel(
      name: 'A arte da guerra',
      image: 'https://images-na.ssl-images-amazon.com/images/I/91ltylqzzdL.jpg',
    ),
  ];
}
