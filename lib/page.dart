import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_17/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startController.text = '';
    endController.text = '';
  }

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  List<Widget> calculationResult(List<int> results) {
    List<Widget> calculationResultWidget = [];
    for (var element in results) {
      calculationResultWidget.add(
        Text(
          element.toString()+', '
        )
      );
    }
    return calculationResultWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prime number checker"),
      ),
      body: BlocProvider(
        create: (context) {
          return ApplicationBloc(ApplicationInitial(result: const []));
        },
        child: BlocBuilder<ApplicationBloc, AppState>(
          builder: (context, applicationState) {
            return applicationState is ApplicationLoading ? const Center(
              child: Text("Loading..."),
            ) : applicationState is ApplicationError ? const Center(
              child: Text("Error..."),
            ) : applicationState is ApplicationInitial ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // input
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            child: TextFormField(
                              controller: startController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                labelText: "Start",
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
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            child: TextFormField(
                              controller: endController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                labelText: "End",
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
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: MaterialButton(
                      onPressed: (){
                        if ((startController.text != '' || startController.text.isNotEmpty) && (endController.text != '' || endController.text.isNotEmpty)) {
                          BlocProvider.of<ApplicationBloc>(context).add(
                            CalculatePrimeNumber(
                              start: int.parse(startController.text),
                              end: int.parse(endController.text)
                            )
                          );
                        }
                      },
                      height: 45,
                      minWidth: 100,
                      child: const Text('CALCULATE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                      textColor: Colors.white,
                      color: Colors.blue,
                      shape: const StadiumBorder(),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  // result here
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Result:"
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Wrap(
                      children: calculationResult(applicationState.result),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  ExpansionTile(
                    title: const Text("My profile"),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/default_profile_picture.png"
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Stany Lius",
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    "stanylius97@gmail.com",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launch('https://www.linkedin.com/in/stany-lius-903860192/');
                                        },
                                        child: const Text(
                                          "LInkedIn",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      InkWell(
                                        onTap: () {
                                          launch('https://github.com/Stanylius');
                                        },
                                        child: const Text(
                                          "Github",
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],  
                  )
                ],
              ),
            ) : Container();
          },
        ),
      ),
    );
  }
}