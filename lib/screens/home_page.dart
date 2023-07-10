import 'package:flutter/material.dart';
import 'package:madground/screens/room_page.dart';

class HomePage extends StatelessWidget {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [HomeListView(items: items)],
    );
  }
}

class HomeListView extends StatelessWidget {
  final List<String> items;

  const HomeListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: const Color.fromARGB(255, 60, 60, 60),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: RoomListItem(),
            );
          },
        ),
      ),
    );
  }
}

class RoomListItem extends StatelessWidget {
  const RoomListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomPage()),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(0),
                ),
                child: Image.network(
                  'https://picsum.photos/seed/55/600',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hd',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '8/10',
                      style: Theme.of(context).textTheme.bodyMedium ,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
