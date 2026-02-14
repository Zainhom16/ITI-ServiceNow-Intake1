// Library Management System + All Bouns
let allBooks = [];
let selection;

function AddBook() {
  let bookTitle;
  do {
    bookTitle = prompt("Enter a Valid Book Title");
  } while (!bookTitle || bookTitle.trim() === "");

  let bookAuthor;
  do {
    bookAuthor = prompt("Enter a valid Author Name");
  } while (!bookAuthor || bookAuthor.trim() === "");

  let numerOfCopies;
  do {
    numerOfCopies = prompt("Enter Number of Copies");
  } while (
    numerOfCopies === null ||
    numerOfCopies.trim() === "" ||
    isNaN(numerOfCopies) ||
    Number(numerOfCopies) < 0
  );

  let checkBook = allBooks.find((el) => el.title.trim() === bookTitle.trim());

  if (checkBook) {
    checkBook.availableCopies += Number(numerOfCopies);
  } else {
    allBooks.push({
      title: bookTitle,
      author: bookAuthor,
      availableCopies: Number(numerOfCopies),
      borrowedCopies: 0,
      borrowCount: 0,
    });
  }

  alert("Book Added Successfully!");
}

function BorrowBook() {
  let bookName;
  do {
    bookName = prompt("Enter The book Name you want to borrow");
  } while (!bookName || bookName.trim() === "");

  let book = allBooks.find(
    (el) => el.title.toLowerCase() === bookName.toLowerCase(),
  );

  if (!book) {
    alert("Book not found!");
    return;
  }

  if (book.availableCopies <= 0) {
    alert("No available copies!");
    return;
  }

  book.availableCopies--;
  book.borrowedCopies++;
  book.borrowCount++;
  alert("Book Borrowed Successfully!");
}

function ReturnBook() {
  let bookName;
  do {
    bookName = prompt("Enter The book Name you want to return");
  } while (!bookName || bookName.trim() === "");

  let book = allBooks.find(
    (el) => el.title.toLowerCase() === bookName.toLowerCase(),
  );

  if (!book) {
    alert("Book not found!");
    return;
  }

  if (book.borrowedCopies <= 0) {
    alert("Error: You didn't borrow this book!");
    return;
  }

  book.availableCopies++;
  book.borrowedCopies--;

  alert("Book Returned Successfully!");
}

function CalculateTotalBooks() {
  allBooks.forEach((el) => {
    console.log(
      `Book: ${el.title} | Total Borrowed: ${el.borrowedCopies} | Total Available: ${el.availableCopies}`,
    );
  });
}

function getBookStatus(book) {
  if (book.availableCopies > 2) return "Available";
  if (book.availableCopies > 0) return "Limited";
  return "Out of Stock";
}

function ShowReport() {
  let totalBorrowed = 0;
  let totalAvailable = 0;
  let report = "";

  allBooks.forEach((el) => {
    let status = getBookStatus(el);
    report += `Book: ${el.title} | Author: ${el.author} | Status: ${status} | Total Borrowed: ${el.borrowedCopies} | Total Available: ${el.availableCopies} | Borrow History: ${el.borrowCount}\n`;
    totalBorrowed += el.borrowedCopies;
    totalAvailable += el.availableCopies;
  });

  report += `\nTotal Borrowed Books: ${totalBorrowed}`;
  report += `\nTotal Available Books: ${totalAvailable}`;

  alert(report);
}

do {
  selection = Number(
    prompt(
      "Welcome to the Library Management System:\n" +
        "1. Add New Book\n" +
        "2. Borrow Book\n" +
        "3. Return Book\n" +
        "4. Calculate Total Books\n" +
        "5. Exit",
    ),
  );

  switch (selection) {
    case 1:
      AddBook();
      break;
    case 2:
      BorrowBook();
      break;
    case 3:
      ReturnBook();
      break;
    case 4:
      CalculateTotalBooks();
      break;
    case 5:
      ShowReport();
      alert("Exiting...");
      break;
    default:
      alert("Invalid Choice");
  }
} while (selection !== 5);
