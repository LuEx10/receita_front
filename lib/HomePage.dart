import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<NavigationRailDestination> testes = [
    //Empresa
    const NavigationRailDestination(
      icon: Icon(Icons.search),
      label: Text('Teste: pesquisa'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.favorite),
      label: Text('Teste: criar Comentários/Likes'),
    ),
  ];

  Widget updatePage(selectedIndex) {
    final Options = [
      //CadastroPage(),
      SearchPreview(),
      CommentPreview()
    ];
    return Options[selectedIndex];
  }

  NavigationRail navigationMenu(BoxConstraints constraints) {
    var appState = context.watch<MyAppState>();
    return NavigationRail(
      extended: constraints.maxWidth >= 600,
      //leading: Placeholder(),
      /*const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Pesquisa',
        ),
      ),*/
      destinations: testes,
      selectedIndex: appState.selectedIndex,
      onDestinationSelected: (value) {
        appState.setPage(updatePage(value));
        setState(() {
          appState.setIndex(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget menu = Placeholder(); //menu atual
    var appState = context.watch<MyAppState>();

    return LayoutBuilder(builder: (context, constraints) {
      /*if (appState.logado) {
        menu = navigationMenu(constraints);
      } else {
        menu = EmptyMenu();
      }*/
      menu = navigationMenu(constraints);
      return Scaffold(
        /*floatingActionButton: ElevatedButton(
          onPressed: () {
            appState.erro("placeholder de ação -> deslogar");
            //appState.deslogar();
            //appState.TESTE_toggle_tipoLogado();
            //appState.TESTE_adm();
          },
          child: const Text('Deslogar'),
        ),
        */
        body: Row(
          children: [
            SafeArea(
              child: menu,
              /*child: Column(
                children: [
                  //Placeholder(),
                  menu,
                ],
              ),*/
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: appState.page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class EmptyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
