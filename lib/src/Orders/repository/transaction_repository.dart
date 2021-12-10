import 'package:tyba_test/src/Orders/models/transaction_model.dart';

class TransactionRepository {
  final List<Transaction> transactions = [
    Transaction(
      date: DateTime.now(),
      value: -60000,
      description: 'Pago de servicio',
      name: "Pago del agua del mes de mayo",
    ),
    Transaction(
      date: DateTime.now().subtract(const Duration(days: 10)),
      value: -45350,
      description: 'Pago de servicio',
      name: "Pago de la luz del mes de mayo",
    ),
    Transaction(
        date: DateTime.now().subtract(const Duration(days: 45)),
        value: 4345000,
        description: 'Sueldo',
        name: "Sueldo de mayo del trabajo"),
    Transaction(
        date: DateTime.now().subtract(const Duration(days: 48)),
        value: -230000,
        description: 'Compra en restaurante',
        name: "Almuerzo para 20 personas"),
    Transaction(
        date: DateTime.now().subtract(const Duration(days: 53)),
        value: -23000,
        description: 'Compra en cine',
        name: "Salida a ver peliculas"),
    Transaction(
        date: DateTime.now().subtract(const Duration(days: 60)),
        value: -4000,
        description: 'Compra suscripción app',
        name: "Suscripción a la app"),
  ];

  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return transactions;
  }
}
