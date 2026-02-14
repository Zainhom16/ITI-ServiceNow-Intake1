// Ask Useer to input a Number Greater Than 100 - Also Handel Cancle
let input = prompt("Enter number greater than 100");

while (input !== null && Number(input) <= 100) {
  input = prompt("Wrong - Enter number greater than 100");
}

if (input === null) {
  console.log("User canceled");
} else {
  console.log("Valid number:", input);
}
