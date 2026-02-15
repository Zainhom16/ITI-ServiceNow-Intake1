// Check If user name is Admain & Password is TheMaster - else console the error
let userInput = prompt("Please enter your name:");
if (userInput == "Admin") {
  let password = prompt("Please enter your password:");
  if (password == "TheMaster") {
    console.log("Welcome");
  } else if (password == "Cancel" || password == "") {
    console.log("Canclled");
  } else {
    console.log("Wrong Password");
  }
}
