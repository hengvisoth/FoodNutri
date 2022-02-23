
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 210,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Image.network(
                                  'https://media-exp1.licdn.com/dms/image/C511BAQFKcHgnNokmfw/company-background_10000/0/1548870617921?e=2159024400&v=beta&t=LvrP2gIEVkf8HTeI9HgBrGeihbYapuuqh7803UvtlUw',
                                  width: MediaQuery.of(context).size.width,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.85, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 90, 0, 0),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    // child: Image.asset(
                                    //   'assets/images/UI_avatar@2x.png',
                                    // ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:  EdgeInsetsDirectional.fromSTEB(
                                    24, 140, 0, 0),
                                child: Text(
                                  '[User Name Here]',
                                  style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF090F13),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding:  EdgeInsetsDirectional.fromSTEB(
                                      24, 174, 0, 0),
                                  child: Text(
                                    'username@domain.com',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color:  Color(0xFFEE8B60),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
               Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 12),
                child: Text(
                  'Account Settings',
                  style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                          child: Text(
                            'Order History',
                            style:
                                TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color:  Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                         Expanded(
                          child:  Align(
                            alignment: AlignmentDirectional(0.9, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF95A1AC),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding:
                                 EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color:  Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                           Expanded(
                            child:  Align(
                              alignment: AlignmentDirectional(0.9, 0),
                              child:  Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF95A1AC),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                           Expanded(
                            child:  Align(
                              alignment:  AlignmentDirectional(0.9, 0),
                              child:  Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF95A1AC),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       FFButtonWidget(
          //         onPressed: () {
          //           print('Button pressed ...');
          //         },
          //         text: 'Log Out',
          //         options: FFButtonOptions(
          //           width: 90,
          //           height: 40,
          //           color: Colors.white,
          //           textStyle: FlutterFlowTheme.of(context).bodyText2.override(
          //                 fontFamily: 'Lexend Deca',
          //                 color: const Color(0xFF4B39EF),
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.normal,
          //               ),
          //           elevation: 3,
          //           borderSide: const BorderSide(
          //             color: Colors.transparent,
          //             width: 1,
          //           ),
          //           borderRadius: 8,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}