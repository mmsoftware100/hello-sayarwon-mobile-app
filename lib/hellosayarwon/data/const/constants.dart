// api


// https://wp.hellokhunmor.com
const String backendApiServer = "https://wp.hellosayarwon.com"; // /wp-json/api/articles?page=1"; //  "https://imirror.mmsoftware100.com";
//const String backendApiServer = "https://wp.hellokhunmor.com"; // /wp-json/api/articles?page=1"; //  "https://imirror.mmsoftware100.com";

const String apiVersion = '$backendApiServer/wp-json/api';
const String loginEndpoint = '$apiVersion/login';
const String meEndpoint = '$apiVersion/me';
const String userRegisterEndpoint = '$apiVersion/register';
const String articleEndpoint = '$apiVersion/article';
const String articleSearchEndpoint = '$apiVersion/search';
const String categoryEndpoint = '$apiVersion/category';
const String articlesEndpoint = '$apiVersion/articles';
const String categoriesEndpoint = '$apiVersion/categories';

// database
const String dbName = 'hello_sayarwon';
const int dbVersion = 2;

const String articleTableName = 'articles';


// column names
String articleTableColumnId = "id";
String articleTableColumnTitle = "title";
String articleTableColumnDescription = "description";
String articleTableColumnThumbnail = "thumbnail";
String articleTableColumnPermalink = "permalink";
String articleTableColumnCategoryId = "category_id";
String articleTableColumnFavourite = "favourite";
String articleTableColumnSources = "sources";
String articleTableColumnCreatedAt = "created_at";
String articleTableColumnUpdatedAt = "updated_at";
// table creation query
// String createPersonTableQuery = "CREATE TABLE $personTableName ($personTableColumnId INTEGER PRIMARY KEY AUTOINCREMENT,$personTableColumnName TEXT,$personTableColumnDescription TEXT)";

String createArticleSql = '''
      CREATE TABLE $articleTableName (
        $articleTableColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $articleTableColumnTitle TEXT,
        $articleTableColumnDescription TEXT,
        $articleTableColumnThumbnail TEXT,
        $articleTableColumnPermalink TEXT,
        $articleTableColumnCategoryId INTEGER,
        $articleTableColumnFavourite INTEGER,
        $articleTableColumnSources TEXT,
        $articleTableColumnCreatedAt TEXT,
        $articleTableColumnUpdatedAt TEXT
      )
''';

const String FCM_TOPIC = "hello_sayarwon";
const String COVER_PHOTO_URL = "https://i.ibb.co/Th9DDh5/Screenshot-2024-05-17-at-09-54-19.png";//  "https://i.ibb.co/VBJ3F5j/Screenshot-2024-05-17-at-09-42-28.png"; // "https://i.ibb.co/P1TJwmq/0-02-06-bf71cf393816c35c57a578bfe00648591208636281e0f88d953e93bf2a11652e-217c7df7300.jpg"; //  "https://i.ibb.co/p009GCH/Naypyidaw-Tours.jpg";
