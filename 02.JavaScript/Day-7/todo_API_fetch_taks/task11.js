// Tasks
// 1- Count how many todos are completed
// 2- Displat titles longer than 20
// 3- Map todo to new array

fetch("https://jsonplaceholder.typicode.com/todos")
  .then((res) => res.json())
  .then((todos) => {
    console.log(todos);
    console.log(
      "Number of completed: " + todos.filter((el) => el.completed).length,
    );
    console.log("Todos with title longer than 20 characters:");
    todos
      .filter((el) => el.title.length > 20)
      .forEach((el) => console.log(el.title));

    console.log("The new todo List");
    let newTodo = todos.map((el) => ({
      id: el.userId,
      titleLength: el.title.length,
    }));

    console.log(newTodo);
  })
  .catch((err) => console.error(err));
