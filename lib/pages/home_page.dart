import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';

var homePageKey = GlobalKey<_HomePageState>();

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  // ignore: overridden_fields
  Key key = homePageKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  
  late double _widthOfScreen;
  final ScrollController _scroller = ScrollController();

  void gotoTop() {
    _scroller.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        controller: _scroller,
        slivers: [
          _buildSliverAppBar(),
          _buildStoryList(),
          _buildPostList(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
        // pinned: true,
        // leading: IconButton(
        //   onPressed: () {
        //     // Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.camera_alt,
        //     color: Colors.black,
        //   ),
        // ),
        // centerTitle: true,
        title: const Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontFamily: 'Billabong',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ]);
  }

  Widget _buildStoryList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: postList.length,
            itemBuilder: (context, index) {
              return _buildStoryItem(postList[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStoryItem(Post item) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 2,
        left: 5,
      ),
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildCircleImage(item.img),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              width: 60,
              height: 20,
              child: Text(item.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleImage(String img) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.purple,
                Colors.orange,
              ],
            ),
          ),
        ),
        SizedBox(
          width: 78,
          height: 78,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1.5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildListItem(mainPostList[index]);
        },
        childCount: mainPostList.length,
      ),
    );
  }

  Widget _buildListItem(Post item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 620,
      width: _widthOfScreen,
      // color: Colors.grey.withOpacity(0.5),
      child: Column(
        children: [
          _buildItemProfile(item),
          _buildItemImage(item.img),
          _buildItemMenu(),
        ],
      ),
    );
  }

  Widget _buildItemMenu() {
    return Container(
      height: 50,
      width: _widthOfScreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            // color: Colors.purple.withOpacity(0.5),
            width: 300,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.message_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_border,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemImage(String image) {
    return SizedBox(
      width: _widthOfScreen,
      height: 510,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildItemProfile(Post item) {
    return SizedBox(
      height: 60,
      // color: Colors.green,
      width: _widthOfScreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            width: 300,
            // color: Colors.yellow,
            child: Row(
              children: [
                _buildProfileCircleImage(item.img),
                const SizedBox(
                  width: 10,
                ),
                Text(item.id),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileCircleImage(String img) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.purple,
                Colors.orange,
              ],
            ),
          ),
        ),
        SizedBox(
          width: 45,
          height: 45,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

