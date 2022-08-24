import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_17/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return ApplicationBloc(ApplicationInitial(result: ''));
        },
        child: BlocBuilder<ApplicationBloc, AppState>(
          builder: (context, applicationState) {
            return applicationState is ApplicationLoading ? Center(
              child: Text("Loading..."),
            ) : applicationState is ApplicationError ? Center(
              child: Text("Error..."),
            ) : applicationState is ApplicationInitial ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // input
                Container(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    child: TextFormField(
                      controller: inputController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: "Input",
                        hintText: "Enter a number",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Input is required";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // 1st row buttons
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ApplicationBloc>(context).add(
                              EventOne(
                                input: int.parse(inputController.text)
                              )
                            );
                          },
                          height: 45,
                          minWidth: 100,
                          child: const Text('1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          textColor: Colors.white,
                          color: Colors.red,
                          shape: const StadiumBorder(),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ApplicationBloc>(context).add(
                              EventTwo(
                                input: int.parse(inputController.text)
                              )
                            );
                          },
                          height: 45,
                          minWidth: 100,
                          child: const Text('2', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          textColor: Colors.white,
                          color: Colors.red,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                // 2nd row buttons
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ApplicationBloc>(context).add(
                              EventThree(
                                input: int.parse(inputController.text)
                              )
                            );
                          },
                          height: 45,
                          minWidth: 100,
                          child: const Text('3', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          textColor: Colors.white,
                          color: Colors.red,
                          shape: const StadiumBorder(),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){
                            BlocProvider.of<ApplicationBloc>(context).add(
                              EventFour(
                                input: int.parse(inputController.text)
                              )
                            );
                          },
                          height: 45,
                          minWidth: 100,
                          child: const Text('4', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          textColor: Colors.white,
                          color: Colors.red,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // result here
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Result"
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        applicationState.result
                      )
                    ],
                  )
                )
              ],
            ) : Container();
          },
        ),
      ),
    );
  }
}