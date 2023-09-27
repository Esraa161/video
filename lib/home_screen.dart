import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
bool fullscreen = false;
String video='https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm';
final List<Map<String, dynamic>> dataList = [
  {
    'video': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'title': 'Video 1',
  },
  {
    'video': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
    'title': 'Video 2',
  },
  {
    'video': 'https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8',
    'title': 'Video 3',
  },
];
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullscreen == false
          ? AppBar(
        backgroundColor: Colors.teal,
        title: const Icon(Icons.video_camera_back_outlined,size: 30,color: Colors.white,),
        centerTitle: true,

      )
          : null,
      body: Column(
        children: [
          Padding(
            padding:
            fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top:5),
            child: YoYoPlayer(
              aspectRatio: 16 / 9,
              url: video,
               //'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
               //"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
              // "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
             // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
              allowCacheFile: true,
              onCacheFileCompleted: (files) {
                print('Cached file length ::: ${files?.length}');

                if (files != null && files.isNotEmpty) {
                  for (var file in files) {
                    print('File path ::: ${file.path}');
                  }
                }
              },
              onCacheFileFailed: (error) {
                print('Cache file error ::: $error');
              },
              videoStyle: const VideoStyle(
               fullScreenIconColor: Colors.white,
                videoQualityBgColor: Colors.black87,


                videoQualityRadius: BorderRadius.all(Radius.circular(5)),
                qualityStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                forwardAndBackwardBtSize: 30.0,
                playButtonIconSize: 40.0,
                playIcon: Icon(
                  Icons.play_arrow,
                  size: 40.0,
                  color: Colors.white,
                ),
                pauseIcon: Icon(
                  Icons.pause,
                  size: 40.0,
                  color: Colors.white,
                ),
                videoQualityPadding: EdgeInsets.all(5.0),
                // showLiveDirectButton: true,
                // enableSystemOrientationsOverride: false,
              ),
              videoLoadingStyle: const VideoLoadingStyle(
                loading: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image(
                      //   image: NetworkImage('https://cdn.icon-icons.com/icons2/2770/PNG/512/camera_video_icon_176703.png'),
                      //   fit: BoxFit.fitHeight,
                      //   height: 50,
                      // ),
                      CircularProgressIndicator(color: Colors.red,),
                      SizedBox(height: 16.0),
                      Text("Loading video..."),
                    ],
                  ),
                ),
              ),
              onFullScreen: (value) {
                setState(() {
                  if (fullscreen != value) {
                    fullscreen = value;
                  }
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];

                return InkWell(
                  onTap: (){
                    setState(() {
                     video=  item['video'];
                      print(item['video']);
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (context) => HomeScreen()),
                     );
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       CircleAvatar(
                         child: Icon(Icons.video_camera_back,
                         color: Colors.teal,),
                         backgroundColor: Colors.teal.shade50,
                       ),
                        SizedBox(height: 8.0),
                        Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 16.0,



                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),


    );
  }
}
