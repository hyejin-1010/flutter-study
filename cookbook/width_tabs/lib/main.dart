import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.download_sharp)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Container(
                child: DownloadPage(),
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;
  double get progress;

  void startDownload();
  void stopDownload();
  void openDownload();
}

class DownloadPage extends StatefulWidget {
  DownloadPage({ Key? key }) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  late final List<DownloadController> _downloadControllers;

  @override
  void initState() {
    super.initState();

    _downloadControllers = List<DownloadController>.generate(
      20,
      (index) => SimulatedDownloadController(
        onOpenDownloaded: () {
          _openDownload(index);
        },
      ),
    );
  }

  void _openDownload(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Open App ${index + 1}'),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apps')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: _downloadControllers.length,
      separatorBuilder: (Context, index) => const Divider(),
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final downloadController = _downloadControllers[index];
    return ListTile(
      leading: const DemoAppIcon(),
      title: Text(
        'App ${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.headline6,
      ),
      subtitle: Text(
        'Lorem ipsum dolor #${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.caption,
      ),
      trailing: SizedBox(
        width: 96.0,
        child: AnimatedBuilder(
          animation: downloadController,
          builder: (context, child) {
            return DownloadButton(
              status: downloadController.downloadStatus,
              progress: downloadController.progress,
              onDownload: downloadController.startDownload,
              onCancel: downloadController.stopDownload,
              onOpen: downloadController.openDownload,
            );
          },
        ),
      ),
    );
  }
}

@immutable
class DemoAppIcon extends StatelessWidget {
  const DemoAppIcon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.0,
      child: SizedBox(
        width: 80.0,
        height: 80.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SimulatedDownloadController extends DownloadController with ChangeNotifier {
  SimulatedDownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    double progress = 0.0,
    required VoidCallback onOpenDownloaded
  }) : _downloadStatus = downloadStatus,
      _progress = progress,
      _onOpenDownload = onOpenDownloaded;
  DownloadStatus _downloadStatus;
  @override
  DownloadStatus get downloadStatus => _downloadStatus;

  double _progress;
  @override
  double get progress => _progress;

  final VoidCallback _onOpenDownload;

  bool _isDownloading = false;

  @override
  void startDownload() {
    if (downloadStatus == DownloadStatus.notDownloaded) {
      _doSimulatedDownload();
    }
  }

  @override
  void stopDownload() {
    _isDownloading = false;
    _downloadStatus = DownloadStatus.notDownloaded;
    _progress = 0.0;
    notifyListeners();
  }

  @override
  void openDownload() {
    if (downloadStatus == DownloadStatus.downloaded) {
      _onOpenDownload();
    }
  }

  Future<void> _doSimulatedDownload() async {
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchingDownload;
    notifyListeners();

    await Future<void>.delayed(const Duration(seconds: 1));

    if (_isDownloading) {
      return;
    }

    _downloadStatus = DownloadStatus.downloading;
    notifyListeners();

    const downloadProgressStops = [0.0, 0.15, 0.45, 0.80, 1.0];
    for (final stop in downloadProgressStops) {
      await Future<void>.delayed(const Duration(seconds: 1));

      if (!_isDownloading) {
        return;
      }

      _progress = stop;
      notifyListeners();
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!_isDownloading) {
      return;
    }

    _downloadStatus = DownloadStatus.downloaded;
    _isDownloading = false;
    notifyListeners();
  }
}

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded
}

@immutable
class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    required this.status,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.progress = 0.0,
    required this.onDownload,
    required this.onCancel,
    required this.onOpen,
  }) : super(key: key);

  final DownloadStatus status;
  final Duration transitionDuration;
  final double progress;

  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onOpen;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool get _isDownloading => widget.status == DownloadStatus.downloading;
  bool get _isFetching => widget.status == DownloadStatus.fetchingDownload;
  bool get _isDownloaded => widget.status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (widget.status) {
      case DownloadStatus.notDownloaded:
        widget.onDownload();
        break;
      case DownloadStatus.fetchingDownload:
        // do nothing
        break;
      case DownloadStatus.downloading:
        widget.onCancel();
        break;
      case DownloadStatus.downloaded:
        widget.onOpen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          _buildButtonShape(
            child: _buildText(),
          ),
          _buildDownloadingProgress(),
        ],
      ),
    );
  }

  Widget _buildDownloadingProgress() {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
        curve: Curves.ease,
        child: Stack(
          children: [
            _buildProgressIndicator(),
            if (_isDownloading)
              const Icon(
                Icons.stop,
                size: 14.0,
                color: CupertinoColors.activeBlue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: widget.progress),
        duration: const Duration(milliseconds: 200),
        builder: (BuildContext context, double progress, Widget? child) {
          return CircularProgressIndicator(
            backgroundColor: _isDownloading ? CupertinoColors.lightBackgroundGray : Colors.white.withOpacity(0.0),
            valueColor:
              AlwaysStoppedAnimation(_isFetching ? CupertinoColors.lightBackgroundGray : CupertinoColors.activeBlue),
            strokeWidth: 2.0,
            value: _isFetching ? null : progress,
          );
        },
      ),
    );
  }

  Widget _buildText() {
    final text = _isDownloaded ? 'OPEN' : 'GET';
    final opacity = _isDownloading || _isFetching ? 0.0 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: widget.transitionDuration,
        opacity: opacity,
        curve: Curves.ease,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button?.copyWith(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonShape({
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: widget.transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: _isDownloading || _isFetching
        ? ShapeDecoration(
            shape: const CircleBorder(),
            color: Colors.white.withOpacity(0.0),
          )
        : const ShapeDecoration(
            shape: StadiumBorder(),
            color: CupertinoColors.lightBackgroundGray,
          ),
      child: child,
    );
  }
}

