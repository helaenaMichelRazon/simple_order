const menu = {
  'Adobo rice': 85.0,
  'Iced tea': 35.0,
  'Turon': 25.0,
};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];

  if (price == null) {
    throw ArgumentError('Item "$name" is not on the menu.');
  }

  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) {
  return items.fold(
    0.0,
        (sum, item) => sum + item.subtotal,
  );
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  final customerName = customer ?? 'Guest';
  final subtotal = total(items);

  double discount = 0.0;

  if (subtotal >= 300) {
    discount = subtotal * 0.10;
  } else {
    discount = 0.0;
  }

  final finalTotal = subtotal - discount;

  print('\n================================');
  print('Order for $customerName');
  print('================================');

  for (final item in items) {
    final itemName = '${item.qty} x ${item.name}'.padRight(23);
    final amount = item.subtotal.toStringAsFixed(2).padLeft(8);

    print('$itemName$amount');
  }

  print('--------------------------------');

  print(
    '${'Subtotal'.padRight(23)}'
        '${subtotal.toStringAsFixed(2).padLeft(8)}',
  );

  if (discount > 0) {
    print(
      '${'Discount 10%'.padRight(23)}'
          '${'-${discount.toStringAsFixed(2)}'.padLeft(8)}',
    );
  }

  print(
    '${'Total'.padRight(23)}'
        '${finalTotal.toStringAsFixed(2).padLeft(8)}',
  );

  print('================================');
}

void main() {
  final guestOrder = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];

  printReceipt(guestOrder);

  final customerOrder = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 1),
  ];

  printReceipt(customerOrder, customer: 'Juan Dela Cruz');
}
