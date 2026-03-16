
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/chatbot.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/services/blocs/controllers/homeviewcontroller.dart';
import 'package:vicuna/services/blocs/events/analysisevent.dart';
import 'package:vicuna/services/blocs/states/analystate.dart';
import 'package:vicuna/services/blocs/states/authenticationState.dart';
import 'package:vicuna/services/blocs/states/modelstate.dart';
import 'package:vicuna/services/misc/constants.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:vicuna/widgets/errorwidget.dart';
import 'package:vicuna/widgets/fileViewer.dart';
import 'package:vicuna/widgets/loading.dart';
import 'package:vicuna/widgets/prodloader.dart';
import 'package:vicuna/widgets/reportCard.dart';
import 'package:vicuna/widgets/userIcon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int screenIndex = 0;
  List<XFile> uploadedFiles = [];

  void rmvd(XFile file) {
    setState(() {
      uploadedFiles.remove(file);
    });
  }
 

  @override
  Widget build(BuildContext ctx) {
    double height = MediaQuery.of(ctx).size.height;
    return BlocBuilder<Authcontroller, Authenticationstate>(
      builder: (context, state) {
        return Scaffold(
          appBar: EpAppBar(
            title: state is SuccessFullAuthenticationState
                 ?"Hi \n  ${state.userCred.displayName ?? "User"}"
                : "Welcome",
            trailing: [UserIcon()],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: SearchBar(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            VicunaVar.borderRadius,
                          ),
                        ),
                      ),
                      hintText: "How Are you Feeling Today?",
                      onSubmitted: (value) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) =>
                                ChatBotScreen(InitialMessage: value),
                          ),
                        ),
                      },
                      leading: Icon(LucideIcons.stethoscope200),
                    ),
                  ),
              
                BlocBuilder <LLMController,ModelState>(builder: (contxt,state){
               
               if(!BlocProvider.of<LLMController>(contxt).ismodelOnDevice) {
               switch (state) {
                  case InitModelState():
                    context.read<LLMController>().pullModel();
                    break;
                  case DownloadingModelState():
                    return DeterminedLoadingWidget(value: state.percentage);
                  
                  case ErrorLoadingModelState():
                    return VicErrorWidget(err:state.error!);

                  default:
                    return LoadingWidget();
                }

                 }
              
               else{
             return  BlocBuilder<QuickAnalysisController, Analystate>(
                    builder: (context, state) {

                      switch(state){

                        case SuccessfulAnalysisState():
                          return ReportCard(report: state.report,);

                        case LoadingAnalysisState():
                          return LoadingWidget();

                      }
                      return 
                           uploadedFiles.isNotEmpty
                          ? FileViewer(files: uploadedFiles, onDelete: rmvd)
                          : SizedBox(
                              height: height * 0.6,
                              child: Opacity(
                                opacity: 0.5,
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.min, 
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, 
                                  spacing: 20,
                                  children: [
                                    Icon(
                                      LucideIcons.notepadText300,
                                      color:
                                          Theme.brightnessOf(ctx) ==
                                              Brightness.light
                                          ? Theme.of(ctx).primaryColor
                                          : Theme.of(ctx).primaryColorLight,
                                      size: 80,
                                    ),
                                    Text(
                                      "Upload Medical report \n for Quick Analysis",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Theme.brightnessOf(ctx) ==
                                                Brightness.light
                                            ? Colors.black45
                                            : Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                      ;
                    },
                  );
               
               
               }
         


                return LoadingWidget();
                

                 })
               
          
               ],
              ),
            ),
          ),
      
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
          
          BlocBuilder<LLMController,ModelState>(
            builder: (ctx,state)
            {
              
               if(ctx.read<LLMController>().ismodelOnDevice){
                return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(VicunaVar.borderRadius),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),

            child: uploadedFiles.isNotEmpty
                ? Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            FilePickerResult? fileResult = await FilePickerIO()
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    "png",
                                    "pdf",
                                    "jpg",
                                    "jpeg",
                                    "csv",
                                  ],
                                );
                            if (fileResult != null) {
                              setState(() {
                                uploadedFiles.addAll(fileResult.xFiles);
                              });
                            }
                          },

                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  VicunaVar.borderRadius,
                                ),
                              ),
                            ),
                          ),
                          icon: Icon(LucideIcons.upload300, size: 20),
                          label: Text("upload", style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ctx.read<QuickAnalysisController>().add(
                              RequestAnalysisEvent(files: uploadedFiles),
                            );
                          },

                          icon: Icon(
                            LucideIcons.scan300,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            "start Analyzing",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? fileResult = await FilePickerIO()
                            .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                "png",
                                "pdf",
                                "jpg",
                                "jpeg",
                                "csv",
                              ],
                            );
                        if (fileResult != null) {
                          setState(() {
                            uploadedFiles.addAll(fileResult.xFiles);
                          });
                        }
                      },

                      icon: Icon(LucideIcons.upload300, size: 20),
                      label: Text(
                        "upload medical report",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          );}
          return SizedBox() ;
          }),
      
        );
      },
    );
  }
}
