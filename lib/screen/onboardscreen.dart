import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/navbar.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/services/blocs/states/modelstate.dart';
import 'package:vicuna/services/repository/localpref.dart';
import 'package:vicuna/widgets/errorwidget.dart';
import 'package:vicuna/widgets/loading.dart';
import 'package:vicuna/widgets/prodloader.dart';

class onBoardData{
  bool online = false;
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late onBoardData data;
  late List<Widget> pages;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    data = onBoardData();
    pages = [
      ModelPage(data: data),
      ModalDownloadedPage()
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: pages.length,
        itemBuilder: (ctx, num) => pages[num],
      ),
      floatingActionButton: TextButton(
        onPressed:  () async {
          debugPrint("currently on ${pageController.page}");
          if(pageController.page == (pages.length - 1.0)){
            context.read<LocalInstance>().OnBoarded(data.online);
             Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NavBar() ));
          }
          else if (pageController.page == (pages.length - 2.0)) {

            if (!data.online) {
                
              await pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            
              }   
        
              else{
                context.read<LocalInstance>().OnBoarded(data.online);
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NavBar() ));
              }
            }
            else {
            await pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          }
        },

        child: Text("next"),
      ),
    );
  }
}
class ModalDownloadedPage extends StatefulWidget {
  const ModalDownloadedPage({super.key});

  @override
  State<ModalDownloadedPage> createState() => _ModalDownloadedPageState();
}

class _ModalDownloadedPageState extends State<ModalDownloadedPage> {
  @override
  Widget build(BuildContext context) {
    return 
    
    
    
    
    
      Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        width: double.maxFinite,
        height: double.maxFinite,
        child:  BlocBuilder<LLMController, ModelState>(
                    builder: (contxt, state) {
                      if (!BlocProvider.of<LLMController>(contxt).ismodelOnDevice) {
                        switch (state) {
                          case InitModelState():
                            context.read<LLMController>().pullModel();
                            break;
                          case DownloadingModelState():
                            return 
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 20,
                                children: [
                                  Text("Downloading Resources",style: TextStyle(fontSize: 20),),
                                  DeterminedLoadingWidget(
                                                    value: state.percentage,
                                                  )
                                  ,Text("Downloading Model, Please wait till all resources are loaded",textAlign: TextAlign.center,)
                                ]
                            );

                          case ErrorLoadingModelState():
                            return VicErrorWidget(err: state.error!);

                          default:
                            return LoadingWidget();
                        }
                        
                      } return LoadingWidget();
  }));
}}

class ModelPage extends StatefulWidget {
  onBoardData data;
  ModelPage({super.key,required this.data});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  @override
  Widget build(BuildContext context) {
    return       Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          spacing: 20,
          children: [
            Text("Welcome", style: TextStyle(fontSize: 20)),
            Opacity(opacity: 0.6, child: Text("pick setup below")),
            GestureDetector(
              onTap: () => setState(() {
                super.widget.data.online = true;
              }),
              child: Card(
                surfaceTintColor: super.widget.data.online
                    ? Colors.tealAccent
                    : Colors.transparent,
                shape: BeveledRectangleBorder(),
                //_selected==1.0?0:1.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text("Cloud Assistant", style: TextStyle(fontSize: 20)),
                      Icon(LucideIcons.cloud, size: 60),
                      Opacity(
                        opacity: 0.6,
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            "Access powerful AI models hosted in the cloud. Enjoy a smooth experience without downloading models. An active internet connection is required.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                super.widget.data.online = false;
              }),
              child: Card(
                surfaceTintColor: !super.widget.data.online
                    ? Colors.tealAccent
                    : Colors.transparent,
                shape: BeveledRectangleBorder(),

                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text("Local Assistant", style: TextStyle(fontSize: 20)),
                      Icon(LucideIcons.download, size: 60),
                      Opacity(
                        opacity: 0.6,
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            "Download and run AI models directly on your device. Enjoy offline access and greater privacy, but keep in mind that performance depends on your device's hardware.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}