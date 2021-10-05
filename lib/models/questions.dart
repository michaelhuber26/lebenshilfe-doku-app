class Question {
  String category;
  String subcategory;
  int result = 0;
  bool isLiked = false;

  Question({required this.category, required this.subcategory});

  @override
  String toString() {
    return '{ ${this.category}, ${this.subcategory}}';
  }
}
