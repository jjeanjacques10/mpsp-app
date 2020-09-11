import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
    queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

class ContactChannels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('canais de contato'),
          ),
          ListTile(
              title: Text('E-mail'),
              onTap: () => launch(
                    _emailLaunchUri.toString(),
                  )),
          ListTile(
            title: Text('Telefone'),
            onTap: () => launch('tel:21213123123'),
          ),
          ListTile(
            title: Text('WhatsApp'),
            onTap: () => launch("whatsapp://send?phone=21213123123"),
          ),
        ],
      ),
    );
  }
}
