


class Pagination{

  int currentPage;
  int totalCount;
  int limit;
  int offset;
  int numberOfPage;

  Pagination({

    required this.currentPage,
    required this.totalCount,
    required this.limit,
    required this.offset,
    required this.numberOfPage
  });

  static Pagination get sample{

    return Pagination(

        currentPage: 0,
        totalCount: 0,
        limit: 0,
        offset: 0,
        numberOfPage: 0
    );
  }
}
