// ===== Данные заказа =====
Map<String, double> menu = {
  'Эспрессо': 800.0,
  'Латте': 1200.5,
  'Капучино': 1150.0,
  'Американо': 900.0,
  'Раф': 1400.0,
};

String drink = 'Эспрессо';
String size = 'S';
int cups = 2;
List<String> extras = ['карамель', 'корица'];
bool hasCard = true;
String payment = 'card';
double promo = 300; // 300 тг — промокод

// Оценки кофейни от гостей
List<int> ratings = [5, 4, 5, 3, 5, 4];

// ===== Анонимные функции (сохранены в переменные) =====

// Форматирование цены
var formatPrice = (double price) => '${price.toStringAsFixed(1)} тг';

// Применение промокода
var applyPromo = (double sum) => sum - promo;

// ===== Функции =====

// Цена за размер (switch)
double sizePrice() {
  switch (size) {
    case 'S':
      return 0;
    case 'M':
      return 200;
    default:
      return 400;
  }
}

// Цена одной чашки
double cupPrice() {
  double drinkPrice = menu[drink]!;
  double extrasPrice = extras.length * 150.0;
  return drinkPrice + sizePrice() + extrasPrice;
}

// Скидка (if / else)
double discount(double sum) {
  if (hasCard) {
    return sum * 0.10;
  } else {
    return 0;
  }
}

// Способ оплаты (switch)
String paymentText() {
  switch (payment) {
    case 'card':
      return 'картой';
    case 'cash':
      return 'наличными';
    default:
      return 'по QR-коду';
  }
}

// Меню с номерами (цикл for)
void printMenu() {
  print('=== МЕНЮ: Coffee Break ===');
  List<String> names = menu.keys.toList();
  for (int i = 0; i < names.length; i++) {
    print('${i + 1}. ${names[i]} — ${formatPrice(menu[names[i]]!)}');
  }
  print('');
}

// Недорогие напитки (where + forEach + анонимные функции)
void printCheapDrinks() {
  print('Напитки дешевле 1000 тг:');
  menu.keys
      .where((name) => menu[name]! < 1000)
      .forEach((name) => print('  * $name — ${formatPrice(menu[name]!)}'));
  print('');
}

// Приготовление заказа (цикл while)
void makeCoffee() {
  int ready = 0;
  while (ready < cups) {
    ready++;
    print('Готовим чашку $ready из $cups: $drink ($size)...');
  }
  print('Заказ готов!');
  print('');
}

// Вывод чека
void printReceipt() {
  double sum = cupPrice() * cups;
  double total = applyPromo(sum - discount(sum));

  print('=== ЧЕК: Coffee Break ===');
  print('Бариста: Нурбек');
  print('Напиток: $drink ($size)');
  print('Добавки (${extras.length} шт.):');

  // forEach с анонимной функцией
  extras.forEach((extra) {
    print('  + $extra — ${formatPrice(150)}');
  });

  if (extras.contains('карамель')) {
    print('Сладкий кофе!');
  }

  print('Цена за чашку: ${formatPrice(cupPrice())}');
  print('Количество чашек: $cups');
  print('Сумма: ${formatPrice(sum)}');
  print('Карта лояльности: $hasCard');
  print('Скидка: -${formatPrice(discount(sum))}');
  print('Промокод: -${formatPrice(promo)}');
  print('ИТОГО: ${formatPrice(total)}');
  print('Оплата: ${paymentText()}');
  print('=========================');
  print('');
}

// Отзывы гостей (for-in + where)
void printRatings() {
  int sum = 0;
  for (int r in ratings) {
    sum += r;
  }
  double average = sum / ratings.length;

  int fives = ratings.where((r) => r == 5).length;

  print('Средняя оценка кофейни: ${average.toStringAsFixed(1)}');
  print('Оценок «5»: $fives из ${ratings.length}');
}

void main() {
  printMenu();
  printCheapDrinks();
  makeCoffee();
  printReceipt();
  printRatings();
}
