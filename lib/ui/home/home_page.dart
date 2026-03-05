import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mdtestapp/bloc/account/auth/bloc.dart';
import 'package:mdtestapp/bloc/account/user/user_bloc.dart';
import 'package:mdtestapp/bloc/account/user/user_event.dart';
import 'package:mdtestapp/bloc/account/user/user_state.dart';
import 'package:mdtestapp/library/app_log.dart';

// Global widgets
import 'package:mdtestapp/widgets/global/dropdown.dart';
import 'package:mdtestapp/widgets/global/text_field.dart';
import 'package:mdtestapp/widgets/global/app_snackbar.dart';

// Reusable widgets
import 'package:mdtestapp/widgets/reusable/re_profile_card.dart';
import 'package:mdtestapp/widgets/reusable/re_user_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc _userBloc = UserBloc();
  AuthBloc _authBloc = AuthBloc();

  final TextEditingController searchController = TextEditingController();
  String filter = "all";

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    _userBloc.add(UserLoadHome());
    super.initState();
  }

  void handleSearch(String value) {
    _userBloc.add(UserSearch(query: value));
  }

  void handleFilter(String value) {
    filter = value;
    _userBloc.add(UserFilter(filter: value));
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F9FF);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Get.offAllNamed("/login");
        }
      },
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bg,
          centerTitle: false,
          title: const Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          actions: [
            IconButton(
              tooltip: "Logout",
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                _authBloc.add(AuthLogout());
              },
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: BlocConsumer<UserBloc, UserState>(
          bloc: _userBloc,
          listener: (context, state) {
            appPrint(context);
            appPrint(state);

            if (state is UserError) {
              AppSnackbar.show(
                context,
                message: state.errorMessage ?? "Error",
                type: AppSnackType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserSuccess) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: Column(
                  children: [
                    ReProfileCard(
                      name: state.name,
                      email: state.email,
                      verified: state.verified,
                      onSendVerification: () {
                        _authBloc.add(AuthResendVerification(null));
                      },
                    ),

                    const SizedBox(height: 14),

                    // Search + Filter
                    Row(
                      children: [
                        Expanded(
                          child: GTextField(
                            controller: searchController,
                            label: "Search",
                            hint: "Search by name or email",
                            prefixIcon: Icons.search_rounded,
                            textInputAction: TextInputAction.search,
                            onChanged: handleSearch,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 150,
                          child: GDropdown<String>(
                            value: filter,
                            label: "Filter",
                            prefixIcon: Icons.tune_rounded,
                            items: const [
                              GDropdownItem(value: "all", label: "All"),
                              GDropdownItem(
                                value: "verified",
                                label: "Verified",
                              ),
                              GDropdownItem(
                                value: "not_verified",
                                label: "Not Verified",
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) handleFilter(value);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // List
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];

                          appPrint(
                            "indexx $index ===> ${user.isEmailVerified}",
                          );

                          return ReUserTile(
                            name: user.name,
                            email: user.email,
                            verified: user.isEmailVerified,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
