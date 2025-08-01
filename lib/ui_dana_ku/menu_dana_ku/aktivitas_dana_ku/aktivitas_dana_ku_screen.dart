// ignore_for_file: prefer_const_constructors

import 'package:finance_riza/controller/dashboard_controller.dart';
import 'package:finance_riza/controller/list_all_transaction_controller.dart';
import 'package:finance_riza/controller/login_controller.dart';
import 'package:finance_riza/routes.dart';
import 'package:finance_riza/style/styles.dart';
import 'package:finance_riza/ui_dana_ku/list_data/list_transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AktivitasDanaKuScreen extends StatelessWidget {
  // Dummy user data
  final String userName = "John Doe";
  final String userBranch = "Central Branch";
  final int saldo = 64594000;

  final Color darkGreen = AppStyles.colorPrimary;
  final Color lightGreen = AppStyles.colorAccent;
  LoginController loginController;
  DashboardController dashboardController;
  ListAllTransactionController listAllTransactionController;

  @override
  Widget build(BuildContext context) {
    loginController = Get.find<LoginController>();
    dashboardController = Get.find<DashboardController>();
    dashboardController.loadDashboard();
    listAllTransactionController = Get.find<ListAllTransactionController>();
    // listAllTransactionController.fetchTransactionsIncome(loginController.userSession['username']);
    // listAllTransactionController.fetchTransactionsTransfer(loginController.userSession['username']);
    // listAllTransactionController.fetchTransactionsExpense(loginController.userSession['username']);

    return Scaffold(
      backgroundColor: lightGreen.withOpacity(0.05),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: darkGreen,
          onRefresh: () async {
            await dashboardController.loadDashboard();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 15),
                    _buildSaldoCard(),
                    const SizedBox(height: 22),
                    _buildMenuButtons(),
                    const SizedBox(height: 22),
                    _buildSectionTitle(),
                    
                  ],
                ),
              ),
              // Expanded list consumes remaining space
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, ),
                  child: ListTransactionData()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.account_circle,
            size: 48,
            color: darkGreen,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loginController.userSession["name"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
            ],
          ),
        ),
       
      ],
    );
  }

 Widget _buildSaldoCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkGreen, lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: darkGreen.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Pemasukan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.green.withOpacity(0.2),
                    child: Icon(
                      FontAwesomeIcons.arrowDown,
                      size: 14,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pemasukan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  'Rp ${_formatCurrency(dashboardController.monthlyIncome.value)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent[100],
                  ),
                ),
              ),
            ],
          ),

          // Pengeluaran
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red.withOpacity(0.2),
                    child: Icon(
                      FontAwesomeIcons.arrowUp,
                      size: 14,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pengeluaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  'Rp ${_formatCurrency(dashboardController.monthlyExpense.value)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent[100],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _MenuButton(
          label: 'Uang Masuk',
          icon: FontAwesomeIcons.arrowDown,
          onTap: () {
            Get.toNamed(RouterGenerator.routeUangMasuk);
          },
          color: lightGreen,
        ),
        _MenuButton(
          label: 'Transfer',
          icon: FontAwesomeIcons.exchangeAlt,
          onTap: () {
            Get.toNamed(RouterGenerator.routeUangMutasiDanaKu);
          },
          color: darkGreen,
        ),
        _MenuButton(
          label: 'Uang Keluar',
          icon: FontAwesomeIcons.arrowUp,
          onTap: () {
            Get.toNamed(RouterGenerator.routeUangKeluarDanaKu);
          },
          color: lightGreen,
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      children: [
        Icon(Icons.list_alt, color: darkGreen, size: 20),
        const SizedBox(width: 8),
        Text(
          'Aktivitas Terbaru',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkGreen,
          ),
        ),
      ],
    );
  }

 

  String _formatCurrency(int value) {
    final digits = value.toString().split('').reversed.toList();
    for (int i = 3; i < digits.length; i += 4) {
      digits.insert(i, '.');
    }
    return digits.reversed.join('');
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _MenuButton({
    Key key,
    this.label,
    this.icon,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: color.withOpacity(0.2),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: FaIcon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppStyles.colorDasar,
            ),
          ),
        ],
      ),
    );
  }
}
