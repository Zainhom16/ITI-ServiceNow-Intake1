// Task 4 + Bouns (Students Mangement System)
let allStudents = [];

do {
  let stdName;
  do {
    stdName = prompt("Enter your Name");
  } while (stdName === null || stdName.trim() === "");

  let studentAge;
  do {
    studentAge = prompt("Enter your Age");
    if (studentAge === null) continue;
  } while (
    studentAge.trim() === "" ||
    isNaN(studentAge) ||
    Number(studentAge) <= 0
  );
  studentAge = Number(studentAge);

  let studentGrades = [];

  while (true) {
    let grade = prompt("Enter your Grade (type Stop to finish)");

    if (grade === "Stop") {
      if (studentGrades.length < 3) {
        alert("You must enter at least 3 grades before stopping!");
        continue;
      } else {
        break;
      }
    }

    if (
      isNaN(grade) ||
      grade.trim() === "" ||
      Number(grade) < 0 ||
      Number(grade) > 100
    ) {
      alert("Error - Enter a grade between 0 and 100");
      continue;
    }

    studentGrades.push(Number(grade));
  }

  const Student = {
    Name: stdName,
    Age: studentAge,
    Grades: studentGrades,
  };

  let sum = Student.Grades.reduce((acc, value) => acc + value, 0);
  let average = sum / Student.Grades.length;
  let highest = Math.max(...Student.Grades);
  let lowest = Math.min(...Student.Grades);

  let classification;
  switch (true) {
    case average >= 90:
      classification = "Excellent";
      break;
    case average >= 80:
      classification = "Very Good";
      break;
    case average >= 70:
      classification = "Good";
      break;
    case average >= 60:
      classification = "Pass";
      break;
    default:
      classification = "Fail";
  }

  console.log("Student Name: " + Student.Name);
  console.log("Student Age: " + Student.Age);
  console.log("Grades: " + Student.Grades);
  console.log("Total Grades Entered: " + Student.Grades.length);
  console.log("Average: " + average.toFixed(2));
  console.log("Highest Grade: " + highest);
  console.log("Lowest Grade:  " + lowest);
  console.log("Result: " + (average >= 60 ? "Passed" : "Failed"));
  console.log("Classification: " + classification);

  allStudents.push({
    name: Student.Name,
    average: average,
    classification: classification,
  });

  let another = prompt("Do you want to enter another student? (yes - no)");
  another = another ? another.trim().toLowerCase() : "no";
} while (another === "yes");

console.log("ALL STUDENTS SUMMARY");
allStudents.forEach((s, index) => {
  console.log(
    index +
      1 +
      ". " +
      s.name +
      " Average: " +
      s.average +
      " Classification: " +
      s.classification,
  );
});
