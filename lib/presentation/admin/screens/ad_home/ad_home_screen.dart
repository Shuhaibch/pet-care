import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/admin/admin_bloc/admin_bloc.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/models/all_data.dart';
import 'package:pet_care/presentation/admin/screens/ad_home/widgets/user_screen.dart';
import 'package:pet_care/presentation/admin/widgets/user_list_tile.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';

List<AllData> allData = [];

class ADHomeScreen extends StatefulWidget {
  const ADHomeScreen({super.key});

  @override
  State<ADHomeScreen> createState() => _ADHomeScreenState();
}

class _ADHomeScreenState extends State<ADHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(GetAllData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AdminBloc, AdminState>(
          // buildWhen: (previous, current) => previous is GetAllDataSuccess,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAllDataSuccess) {
              allData = state.allData;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      "ADIMIN PANAL",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Users List",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => kheight10,
                        itemCount: state.allData.length,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context, index) {
                          final AllData allData = state.allData[index];
                          return InkWell(
                            onTap: () {
                              navigatorKey.currentState!.push(MaterialPageRoute(
                                builder: (context) => UserScreen(
                                  user: allData.myUser,
                                ),
                              ));
                            },
                            child: UserListTile(
                              height: height,
                              title: allData.myUser.name,
                              userRole: allData.myUser.userRole,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (state is GetAllDataError) {
              return Center(
                  child: Text(
                state.errorMsg!,
                style: Theme.of(context).textTheme.displayMedium,
              ));
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
