// Check Password Length is Greater than 8 and throw an error using - try catch block
try {
  let userName = prompt("Enter your Name");
  let password = prompt("Enter Password");
  if (password.length < 8) throw new Error("Password Less than 8 Charachters");
  alert(`Welcome ${userName}`);
} catch (err) {
  alert(`Catched Error: ${err.message}`);
}
