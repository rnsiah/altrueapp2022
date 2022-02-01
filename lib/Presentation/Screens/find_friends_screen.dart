import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Models/manage_followers_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class FindFriends extends StatefulWidget {
  final User user;
  FindFriends({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  ScrollController _scrollController = ScrollController();
  UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Find Friends'),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('Invite Friends'),
              ),
              ListTile(
                title: Text('Contacts'),
              ),
              ListTile(
                title: Text('FaceBook Friends'),
              ),
              Text('Suggested Friends',
                  style: TextStyle(fontSize: 8, color: Colors.blueGrey)),
              BlocBuilder<AllUsersBloc, AllUsersState>(
                builder: (context, state) {
                  if (state.status == ProfileListStatus.successful) {
                    return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.userList.length,
                        itemBuilder: (context, index) => ListTile(
                              onTap: () async {
                                Profile profile =
                                    await userRepository.fetchProfile(
                                        id: state.userList[index].id,
                                        user: widget.user);
                                Navigator.of(context).pushNamed('/profilepage',
                                    arguments: profile);
                              },
                              leading: CircleAvatar(
                                  radius: 45.0,
                                  foregroundImage: NetworkImage(state
                                      .userList[index].profilePicture!.url),
                                  backgroundImage: NetworkImage(state
                                      .userList[index].profilePicture!.url)),
                              title: Text(state.userList[index].username),
                              trailing: MaterialButton(
                                onPressed: () {
                                  ManageFollower follow = ManageFollower(
                                      follow: 'follow',
                                      id: state.userList[index].id);
                                  context
                                      .read<ProfileBloc>()
                                      .add(AddFollower(interaction: follow));

                                  print(follow.toString());
                                },
                                color: Colors.amber,
                                child: Text('Follow'),
                              ),
                            ));
                  } else if (state.status == ProfileListStatus.failure) {
                    Center(
                      child: Text(
                          'Something Went Wrong. Please check your connection'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
