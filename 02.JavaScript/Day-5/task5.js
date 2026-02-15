// Implementing Power Function

function pow(a, b) {
  let result = a;
  for (let i = 1; i <= b; i++) {
    result *= a;
  }
}

pow(2, 3);
