import 'package:flutter/material.dart';
import 'package:storage/model/task_model.dart';
import 'package:storage/model/task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  final TaskProvider _provider = TaskProvider();

  @override
  void initState() {
    _provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Hi {email}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your task',
                    ),
                    controller: _taskController,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: Container(
                child: _provider.list.isEmpty
                    ? Container()
                    : ListView.builder(
                        itemCount: _provider.list.length,
                        itemBuilder: (context, index) {
                          final TaskModel task = _provider.list[index];
                          debugPrint('index: $index/${_provider.list.length}');
                          return ListTile(
                            leading: Text(task.id.toString()),
                            title: Text(task.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
