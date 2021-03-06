import 'package:agendaboa_assignment_parikshit/blocs/counterclub/counterclub_cubit.dart';
import 'package:agendaboa_assignment_parikshit/views/tabs/counter_1_screen.dart';
import 'package:agendaboa_assignment_parikshit/views/tabs/counter_2_screen.dart';
import 'package:agendaboa_assignment_parikshit/views/tabs/counter_3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  void initState() {
    context.read<CounterclubCubit>().initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterclubCubit, CounterclubState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<CounterclubCubit>().resetAll();
                    },
                    icon: const Icon(Icons.clear_all))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is CounterclubProcessing)
                    state.tabIndex == 0
                        ? const Counter1Screen()
                        : state.tabIndex == 1
                            ? const Counter2Screen()
                            : const Counter3Screen(),
                  if (state is CounterclubInitial)
                    state.tabIndex == 0
                        ? const Counter1Screen()
                        : state.tabIndex == 1
                            ? const Counter2Screen()
                            : const Counter3Screen(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<CounterclubCubit>().increment(),
              tooltip: 'Increment',
              child: state is CounterclubProcessing
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: (state is CounterclubInitial
                      ? state.tabIndex
                      : state is CounterclubProcessing
                          ? state.tabIndex
                          : 0) ??
                  0,
              onTap: (index) {
                context.read<CounterclubCubit>().changeTab(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                      size: 18,
                    ),
                    label: 'Counter 1'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                      size: 18,
                    ),
                    label: 'Counter 2'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt,
                      size: 18,
                    ),
                    label: 'Counter 3'),
              ],
            )));
  }
}
