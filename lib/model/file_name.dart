class Kcse{

  final String year;
  final String title;

  Kcse({ required this.year, required this.title,});

  static List<Kcse> papers(){
    return[
      Kcse(year:"2021", title: "K.C.S.E Past paper 2021"),
      Kcse(year:"2020", title: "K.C.S.E Past paper 2020"),
      Kcse(year:"2019", title: "K.C.S.E Past paper 2019"),
      Kcse(year:"2018", title: "K.C.S.E Past paper 2018"),
      Kcse(year:"2017", title: "K.C.S.E Past paper 2017"),
      Kcse(year:"2016", title: "K.C.S.E Past paper 2016"),
      Kcse(year:"2015", title: "K.C.S.E Past paper 2015"),
      Kcse(year:"2014", title: "K.C.S.E Past paper 2014"),
      Kcse(year:"2013", title: "K.C.S.E Past paper 2013"),
      Kcse(year:"2012", title: "K.C.S.E Past paper 2012"),
      Kcse(year:"2011", title: "K.C.S.E Past paper 2011"),
      Kcse(year:"2010", title: "K.C.S.E Past paper 2010"),
    ];
  }
}

class Books{
  final String image;
  final String book;


  Books({required this.image, required this.book});

  static List<Books> bookList() {
    return[    
    Books(image:"assets/images/b1.jpg", book:"Form One"),
    Books(image:"assets/images/b2.jpg", book:"Form Two"),
    Books(image:"assets/images/b3.png", book:"Form Three"),
    Books(image:"assets/images/b4.jpg", book:"Form Four"),


    ];
    }
}

class Otherss{
  
  final String title;

  Otherss({ required this.title});

  static List<Otherss> filePath(){
    return[
      Otherss( title: "Essay Examples"),
      Otherss( title: "Form 1 Topical Questions"),
      Otherss( title: "Form 2 Topical Questions"),
      Otherss( title: "Form 4 Topical Questions"),      
      Otherss( title: "Form 3 Topical Questions"),
      Otherss(title: "Mock Questions & Answers"),
    ];
    
  }
}