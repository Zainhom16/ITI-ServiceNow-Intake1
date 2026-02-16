let button = document.querySelector(".btn-weather");
let input = document.getElementById("weather");

async function checkCity(city) {
  console.log("Loading For 2 Seconds...");

  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (city.toLowerCase() !== "paris") {
        reject(new Error("City Isn't Paris"));
      } else {
        resolve("Success + Weather is 35°C");
      }
    }, 2000);
  });
}

button.addEventListener("click", async function () {
  try {
    let res = await checkCity(input.value);
    console.log(res);
  } catch (err) {
    console.error(err.message);
  }
});
