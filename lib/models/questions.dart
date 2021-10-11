class Question {
  String category;
  String subcategory;
  int result = 0; // 0 = not ansered, 1,2,3,4 = selected pictogram
  bool isLiked = false;

  Question({required this.category, required this.subcategory});

  @override
  String toString() {
    return '{ ${this.category}, ${this.subcategory}}';
  }
}
