import 'package:contend/themes/app_colors.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/base_stateless_widget.dart';

import '../../styles/edge_insets.dart';
import '../../themes/fonts.dart';
import 'users_friends_screen_controller.dart';
import 'users_friends_screen_cubit.dart';

class UsersFriendsScreen extends BaseStatelessWidget<
    UsersFriendsScreenController,
    UsersFriendsScreenCubit,
    UsersFriendsScreenState> {
  UsersFriendsScreen({Key? key, super.controller, super.onStateChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersFriendsScreenCubit>(
      create: (context) => createCubitAndAssignToController(context),
      child: BlocConsumer<UsersFriendsScreenCubit, UsersFriendsScreenState>(
        listener: (context, state) {
          if (onStateChanged != null) {
            onStateChanged!(state);
          }
        },
        builder: (context, state) {
          initializeController(context);
          return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.bmiTracker,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Your friends",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: Fonts.fontNunito,
                            color: AppColors.bmiTracker,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: edge_insets_x_24,
                    child: state.friendListIds!.length > 0
                        ? ListView.builder(
                        itemCount: state.friendListIds!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: edge_insets_t_12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'images/user2.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        margin: edge_insets_l_9,
                                        child: Text(
                                          state.friendListUsers![index].userName,
                                          style: TextStyle(
                                              fontSize: Fonts.fontSize18),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(onTap: () {}, child: Text("Block", style: TextStyle(color: AppColors.textRed),))
                              ],
                            ),
                          );
                        })
                        : Container(
                      margin: edge_insets_t_70,
                      child: Column(
                        children: [
                          Image.asset(
                            'images/illustration.jpeg',
                            width: 200,
                            height: 200,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }

  @override
  UsersFriendsScreenCubit createCubitAndAssignToController(
      BuildContext context) {
    UsersFriendsScreenCubit cubit = UsersFriendsScreenCubit(context: context);
    controller?.cubit = cubit;
    controller?.childContext = context;
    return cubit;
  }
}
