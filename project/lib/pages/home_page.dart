import 'package:flutter/material.dart';
import 'package:notes/SaveNotesService.dart';
import 'package:notes/pages/card.dart';
import 'package:notes/pages/card_add.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteCard> _cards;

  void _updateCardsList() {
    NotesSaver.instance.getAllNotes('notes').then((notes) {
      setState(() {
        _cards = List.from(
          notes.map(
            (note) => NoteCard(
              title: note['title'],
              note: note['note'],
              date: DateTime.tryParse(note['date']),
            ),
          ),
        );
      });
    });
  }

  @override
  initState() {
    super.initState();
    _updateCardsList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            var response = await showDialog(
              context: context,
              builder: (context) => CardAdd(),
            );
            if (response is Map<String, dynamic>) {
              NotesSaver.instance.insert(response, 'notes');
              _updateCardsList();
            }
            // method without database
            // setState(() {
            //   _cards.add(
            //     NoteCard(
            //       title: response['title'],
            //       note: response['note'],
            //       date: DateTime.tryParse(response['date']),
            //     ),
            //   );
            // });
          },
          tooltip: 'Add note',
          color: Colors.black,
        ),
        backgroundColor: Color(
          int.parse("0xFFE4AAAD"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            tooltip: 'More',
            color: Colors.black,
          ),
        ],
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: _cards == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _cards.isEmpty
              ? Center(
                  child: Text('No any notes yet'),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: _cards.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 50.0,
                    mainAxisSpacing: 50.0,
                  ),
                  itemBuilder: (context, index) => Card(
                    color: Color(
                      int.parse("0xFF6D8CD9"),
                    ),
                    elevation: 5.0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _cards[index].title,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            _cards[index].date.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            _cards[index].note,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await NotesSaver.instance
                                .deleteFromDB(_cards.elementAt(index).title);
                            _cards.removeAt(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
