let add_task = document.querySelector(".add_task");
let listContainer = document.getElementById("list-container");
let counter = document.getElementById("count_number");

function updateCounter() {
  counter.textContent = listContainer.querySelectorAll(".single_list").length;
}

add_task.addEventListener("click", function () {
  let inputBox = document.getElementById("input-box");
  let taskText = inputBox.value.trim();

  if (taskText !== "") {
    let taskDiv = document.createElement("div");
    taskDiv.classList.add("single_list");

    let li = document.createElement("li");
    li.textContent = taskText;

    let removeBtn = document.createElement("button");
    removeBtn.classList.add("remove_task");
    removeBtn.textContent = "Remove";

    removeBtn.addEventListener("click", function () {
      taskDiv.remove();
      updateCounter();
    });

    taskDiv.appendChild(li);
    taskDiv.appendChild(removeBtn);

    listContainer.prepend(taskDiv);

    inputBox.value = "";
    updateCounter();
  }
});
