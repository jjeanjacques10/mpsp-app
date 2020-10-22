import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mpsp_app/app/services/user_service.dart';

ListView drawerItems(
    BuildContext context, UserService userRepository, homeScreenStore) {
  return ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Image.asset('assets/images/logo.png'),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
      ),
      ListTile(
        title: Text('Perfil'),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/profile",
          );
        },
      ),
      ListTile(
        title: Text('Histórico de lavagens'),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/history",
          );
        },
      ),
      ListTile(
        title: Text('Contato'),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/contacts",
          );
        },
      ),
      ListTile(
        title: Text('Parceiros'),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/partners",
          );
        },
      ),
      ListTile(
        title: Text('Veículos'),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/new-vehicle",
          );
        },
      ),
      ListTile(
        title: Text('Sair'),
        onTap: () {
          //Deslogar()
          userRepository.logout();
          Navigator.pushReplacementNamed(
            context,
            "/",
          );
        },
      ),
      Observer(builder: (context) {
        return buildAdminListTile(homeScreenStore, context);
      })
    ],
  );
}

Widget buildAdminListTile(homeScreenStore, BuildContext ctx) {
  if (homeScreenStore.name == "Jean Jacques Barros") {
    return ListTile(
      title: Text('Administrador'),
      onTap: () {
        Navigator.pushNamed(
          ctx,
          "/home-admin",
        );
      },
    );
  }
  return ListTile(
    title: Text(''),
    onTap: () {},
  );
}
