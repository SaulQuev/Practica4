import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/styles/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    //PROBAR CAMBIO EN EL TITULO DE LA PANTALLA
    return ValueListenableBuilder(
        valueListenable: GlobalValues.flagTitle,
        builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Bienvenidos 👋')),
            drawer: createDrawer(context),
          );
        });

  
  }
  
  final imgLogo = Container(
      width: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/2919/2919600.png')),
      ),
    );

  Widget createDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://scontent-dfw5-1.xx.fbcdn.net/v/t1.6435-1/147282030_3758020080926332_2824307540345505213_n.jpg?stp=dst-jpg_p240x240&_nc_cat=103&ccb=1-7&_nc_sid=2b6aad&_nc_eui2=AeHNhSWeZOdSC_eaom9mZQ5ILYMAId_ktrEtgwAh3-S2sc7GOFt5XtHpGn87nc_mzPTb5d_JJinl1EHOBaxxG71V&_nc_ohc=NwD6POeGQ9kAX_5uQJM&_nc_ht=scontent-dfw5-1.xx&oh=00_AfATUndvrBb6gbO8gouY7MlQecixz6lT6CaRAQqPbf03hQ&oe=65513997'),//'https://i.pravatar.cc/300'
            ),
            accountName: Text('Saul Quevedo Hernandez'),
            accountEmail: Text('19030099@itcelaya.edu.mx'),
          ),
          ListTile(
            leading: Image.asset('assets/images/tecno.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Instituto Tecnologico de Celaya'),
            subtitle: const Text('Acerca de...'),
            onTap: () {
              //Navigator.pushNamed(context, '/item');
            },
          ),
          ListTile(
            leading: Image.asset('assets/images/carrera.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Carreras'),
            onTap: () {
              Navigator.pushNamed(context, '/careers');
            },
          ),
        
          ListTile(
            leading: Image.asset('assets/images/profe.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Profesores'),
            onTap: () {
              Navigator.pushNamed(context, '/teachers');
            },
          ),
            ListTile(
            leading: Image.asset('assets/images/tarea.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Tareas'),
            onTap: () {
              Navigator.pushNamed(context, '/tasks');
            },
          ),
          
          ListTile(
            leading: Image.asset('assets/images/calendario.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Calendario'),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            leading: Image.asset('assets/images/movie.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Peliculas'),
            onTap: () {
              Navigator.pushNamed(context, '/popular');
            },
          ),
          ListTile(
            leading: Image.asset('assets/images/test.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Test Provider'),
            onTap: () {
              Navigator.pushNamed(context, '/provider');
            },
          ),
          const Spacer(
            flex: 1,
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) async {
              GlobalValues.flagTheme.value = isDarkModeEnabled;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('darkTheme', isDarkModeEnabled);
            },
          ),
          const Divider(),
          ListTile(
            leading: Image.asset('assets/images/logout.png'),
            title: const Text('Cerrar sesion'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogged', false);
              Navigator.pushNamed(context, '/login');
            },
          ),
          
        ],
        
      ),
      
    );
    
  }
}
