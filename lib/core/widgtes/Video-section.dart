import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Feautres/Home/model/Home-model.dart';
import 'package:ecommerce_app/core/utils/Responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class VideoBannerSection extends StatefulWidget {
  final String title;
  final List<VideoBannerItem> videoData;

  const VideoBannerSection({super.key, required this.videoData, required this.title});

  @override
  State<VideoBannerSection> createState() => _VideoBannerSectionState();
}

class _VideoBannerSectionState extends State<VideoBannerSection> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isMuted = false;
  bool _showThumbnail = true;

  bool get _isDesktop => !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);
  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get _isWeb => kIsWeb;

@override
void initState() {
  super.initState();
  _isMuted = true; // Set this before video is initialized
  _initializeVideo();
}


  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.network(
        widget.videoData[0].videoUrl,
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      await _videoPlayerController.initialize();

      _videoPlayerController.addListener(() {
        final controller = _videoPlayerController;
        if (controller.value.position >= controller.value.duration &&
            !controller.value.isPlaying &&
            _isInitialized) {
          controller.seekTo(Duration.zero);
          controller.play();
        }
      });

      setState(() {
        _isInitialized = true;
        _showThumbnail = false;
      });

      if (_isMobile) {
        _setupChewieController();
      }

      _startPlayback();
    } catch (e) {
      debugPrint('Video initialization error: $e');
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  void _setupChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      showControls: false,
      autoInitialize: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(),
      startAt: Duration.zero,
    );
  }

void _startPlayback() {
  if (!_isInitialized || !mounted) return;

  _videoPlayerController.setVolume(_isMuted ? 0 : 1);

  _videoPlayerController.play().catchError((e) {
    debugPrint('Playback error: $e');
    if (mounted) {
      setState(() => _hasError = true);
    }
  });
}


  void _toggleMute() {
    if (!_isInitialized) return;

    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _togglePlayPause() {
    if (!_isInitialized) return;

    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      setState(() => _showThumbnail = true);
    } else {
      _videoPlayerController.play().then((_) {
        if (mounted) {
          setState(() => _showThumbnail = false);
        }
      }).catchError((e) {
        debugPrint('Play error: $e');
        if (mounted) {
          setState(() => _hasError = true);
        }
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: ResponsiveUtils.getSectionPadding(context),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: GestureDetector(
            onTap: isMobile ? _togglePlayPause : null,
            child: Container(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Thumbnail or error state
                  if (_showThumbnail || _hasError || !_isInitialized)
                    CachedNetworkImage(
                      imageUrl: widget.videoData[0].thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.black),
                    ),

                  // Video player
                  if (_isInitialized && !_showThumbnail)
                    _isMobile
                        ? (_chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : Container())
                        : VideoPlayer(_videoPlayerController),

                  // Gradient overlay
                  if (_isInitialized && !_showThumbnail)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),

                  // Play icon (mobile only when paused)
                  if (isMobile && _showThumbnail && _isInitialized)
                    Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),

                  // Mute button
                  if (_isInitialized && !_showThumbnail)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: _toggleMute,
                      ),
                    ),

                  // Text overlay
                  if (_isInitialized && !_showThumbnail)
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          widget.title,
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Limited time only - Shop now",
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
