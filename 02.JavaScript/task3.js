// Function to Check Prime Numers Between Range

function IsPrime(n) {
  for (let i = 2; i < n; i++) {
    if (n % i === 0) return false;
  }
  return true;
}

for (let num = 2; num < 10; num++) {
  if (IsPrime(num)) {
    console.log(num);
  }
}
