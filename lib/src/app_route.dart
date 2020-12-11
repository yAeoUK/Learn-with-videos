import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/home.dart';
import 'package:videos/video.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }

    // Handle '/watch?v=fsdfsdfsd
    if (uri.pathSegments.length == 1) {
      if (!uri.pathSegments[0].startsWith('/watch?')) return AppRoutePath.unknown();
      if(uri.pathSegments[0].startsWith('/watch?v=')){
        var videoId=uri.queryParameters['v'];
        return AppRoutePath.video(videoId);
        /*var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return AppRoutePath.unknown();
        return AppRoutePath.details(id);*/
      }
    }

    // Handle unknown routes
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if(path.isVideoPage){
      return RouteInformation(location: '/watch?v=${path.id}');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //Book _selectedBook;
  bool show404 = false;
  String videoId;
  /*List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];*/

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath get currentConfiguration {
    if (show404) {
      return AppRoutePath.unknown();
    }
    if(videoId!=null) return AppRoutePath.video(videoId);
    /*return _selectedBook == null
        ? AppRoutePath.home()
        : AppRoutePath.details(books.indexOf(_selectedBook));*/
    return AppRoutePath.home();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Catcher.navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('Home'),
          child: MyHomePage()
        ),
        if (show404)
          MaterialPage(key: ValueKey('Unknown'), child: UnknownScreen())
        else if(videoId!=null) VideoPageRoute(videoId: videoId)
        /*else if (_selectedBook != null)
          BookDetailsPage(book: _selectedBook)*/
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        //_selectedBook = null;
        videoId=null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path.isUnknown) {
      //_selectedBook = null;
      videoId=null;
      show404 = true;
      return;
    }

    /*if (path.isDetailsPage) {
      if (path.id < 0 || path.id > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[path.id];
    } else {
      _selectedBook = null;
    }*/

    show404 = false;
  }

  void videoNotFound(){
    videoId=null;
    show404=true;
    notifyListeners();
  }

  /*void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }*/
}

class AppRoutePath {
  final String id;
  final bool isUnknown;

  AppRoutePath.home()
      : id = null,
        isUnknown = false;

  AppRoutePath.details(this.id) : isUnknown = false;

  AppRoutePath.video(this.id): isUnknown=false;

  AppRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;

  bool get isVideoPage => id!=null;
}

/*class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    @required this.books,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}
*/
/*class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({
    @required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
*/
class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
