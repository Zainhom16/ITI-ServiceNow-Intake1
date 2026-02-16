let button = document.querySelector(".btn-weather");
let select = document.getElementById("weather-select");

async function checkCity(city) {
  console.log("Loading For 2 Seconds...");

  return new Promise((resolve, reject) => {
    setTimeout(() => {
      switch (city.toLowerCase()) {
        case "paris":
          resolve("Weather in Paris is 35°C");
          break;
        case "cairo":
          resolve("Weather in Cairo is 30°C");
          break;
        default:
          reject(new Error("City not supported"));
      }
    }, 2000);
  });
}

button.addEventListener("click", async function () {
  try {
    let res = await checkCity(select.value);
    console.log(res);
  } catch (err) {
    console.error(err.message);
  }
});
