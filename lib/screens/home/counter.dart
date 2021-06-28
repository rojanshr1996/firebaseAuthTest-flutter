import 'package:flutter/material.dart';
import 'package:phone_auth_test/event/counterBloc.dart';
import 'package:phone_auth_test/event/counterEvent.dart';
import 'package:phone_auth_test/main.dart';
import 'package:phone_auth_test/utilities.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final _bloc = CounterBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Run counter");
    return Scaffold(
      backgroundColor: AppColor.primaryDarkAccent,
      appBar: AppBar(
        backgroundColor: AppColor.primaryDark,
        title: Text(
          "Counter",
          style: TextStyle(color: AppColor.primary),
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Container(
        height: Utilities.screenHeight(context),
        // width: Utilities.screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: _bloc.counter,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Text(
                        "This is the counter: ${snapshot.data}",
                        style: TextStyle(color: AppColor.white, fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () =>
                          _bloc.counterEventSink.add(IncrementEvent()),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return AppColor.primaryDarkAccent;
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return AppColor.primaryDarkAccent;
                            return AppColor
                                .primaryDarkAccent; // Defer to the widget's default.
                          },
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.primaryDark),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Increment"),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () =>
                            _bloc.counterEventSink.add(DescrementEvent()),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return AppColor.primaryDarkAccent;
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed))
                                return AppColor.primaryDarkAccent;
                              return AppColor
                                  .primaryDarkAccent; // Defer to the widget's default.
                            },
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primaryDark),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Decrement"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
