import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/provider/cart_prov.dart';
import 'package:smartshop/screen/cartscreen.dart';

class AppBaar extends StatelessWidget {
  const AppBaar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined, size: 37),
        ),
        const SizedBox(
          height: 60,
          width: 110,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.local_mall, size: 37),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ),
                )
              },
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return Text("${cart.count}");
                  },
                ))
          ],
        ),
      ],
    );
  }
}
