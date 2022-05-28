import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage/model/auth_provider.dart';
import 'package:storage/model/task_model.dart';
import 'package:storage/model/task_provider.dart';
import 'package:storage/ui/splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    context.read<TaskProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  bool res = await _authProvider.logout();
                  if (res) {
                    await provider.clear();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hi ${_authProvider.email}',
                  style: const TextStyle(
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
                        controller: provider.taskController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.add();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Expanded(
                  child: Container(
                    child: provider.list.isEmpty
                        ? const Center(
                            child: Text('No Data'),
                          )
                        : ListView.builder(
                            itemCount: provider.list.length,
                            itemBuilder: (context, index) {
                              final TaskModel task = provider.list[index];
                              debugPrint(
                                  'index: $index/${provider.list.length}');
                              return ListTile(
                                leading: Text(task.id.toString()),
                                title: Text(task.title),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _showDeleteDialog(context, provider, task);
                                  },
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
      },
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    TaskProvider provider,
    TaskModel task,
  ) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete Task: ${task.title}'),
        content: const Text('Are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text(
              'cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'NotoSansCJKtc',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              provider.delete(task);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text(
              'ok',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'NotoSansCJKtc',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
