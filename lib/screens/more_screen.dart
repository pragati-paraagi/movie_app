import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';


class ProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Who\'s Watching?', style: TextStyle(color: Color(0xffE50914))),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<ProfileProvider>().updateProfileName(index == 4 ? 'Kids' : 'Profile ${index + 1}');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      index == 4 ? 'Kids' : 'Profile ${index + 1}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Icon(Icons.edit, color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Color(0xffE50914)),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffE50914),
                child: Text(
                  profileProvider.profileName[0],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Profile Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE50914)),
                ),
              ),
              controller: TextEditingController(text: profileProvider.profileName),
              style: TextStyle(color: Colors.white),
              onChanged: (newValue) => profileProvider.updateProfileName(newValue),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Autoplay Next Episode', style: TextStyle(color: Colors.white)),
              value: profileProvider.autoplayNextEpisode,
              onChanged: (value) {
                profileProvider.toggleAutoplayNextEpisode(value);
              },
              activeColor: Color(0xffE50914),
            ),
            SwitchListTile(
              title: Text('Autoplay Previews', style: TextStyle(color: Colors.white)),
              value: profileProvider.autoplayPreviews,
              onChanged: (value) {
                profileProvider.toggleAutoplayPreviews(value);
              },
              activeColor: Color(0xffE50914),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Delete Profile', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffE50914),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
